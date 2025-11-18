import nodemailer from "nodemailer";
import cron, { ScheduledTask } from "node-cron";
import { exec } from "child_process";
import fs from "fs";
import path from "path";
import { DATABASE_DOCKER, DATABASE_URL, DEFAULT_RECEIVER_EMAIL, SCHEDULAR_EMAIL } from "../config/envs";
import prisma from "../config/prisma";

// === Backup function ===
async function generateDBBackup(REPORTS_DIR: string): Promise<string> {
	return new Promise((resolve, reject) => {
		try {
			const files = fs.readdirSync(REPORTS_DIR);
			for (const file of files) {
				if (file.endsWith(".sql")) fs.unlinkSync(path.join(REPORTS_DIR, file));
			}

			const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
			const backupFilePath = path.join(REPORTS_DIR, `POS_Backup_${timestamp}.sql`);

			const nativeCommand = `pg_dump ${DATABASE_URL} -f "${backupFilePath}"`;
			const dockerCommand = `docker exec -i postgres-db pg_dump -U postgres smart_pos_db`;
			exec(DATABASE_DOCKER ? dockerCommand : nativeCommand, { maxBuffer: 1024 * 1024 * 500 }, (error, stdout, stderr) => {
				if (error) {
					return reject(error);
				}
				const fs = require('fs');
				fs.writeFileSync(backupFilePath, stdout);  // write container output to host file
				resolve(backupFilePath);
			});
		} catch (err) {
			reject(err);
		}
	});
}

// === Get POS statistics ===
async function getPOSStats() {
	const todayStart = new Date();
	todayStart.setHours(0, 0, 0, 0);
	const todayEnd = new Date();
	todayEnd.setHours(23, 59, 59, 999);

	const startISO = todayStart.toISOString();
	const endISO = todayEnd.toISOString();

	const totalSales: any = await prisma.$queryRaw`
    SELECT COALESCE(SUM(total_amount),0) AS total_sales
    FROM sales_history
    WHERE created_at >= ${todayStart} AND created_at <= ${todayEnd};
  `;

	const totalProfit: any = await prisma.$queryRaw`
    SELECT COALESCE(SUM(profit),0) AS total_profit
    FROM sales_history
    WHERE created_at >= ${todayStart} AND created_at <= ${todayEnd};
  `;

	const totalStock: any = await prisma.$queryRaw`SELECT COALESCE(SUM(quantity),0) AS total_stock FROM inventory;`;
	const totalCredits: any = await prisma.$queryRaw`SELECT COALESCE(SUM(credits),0) AS total_credits FROM customer;`;

	const stockList: any = await prisma.$queryRaw`
    SELECT i.product_id, p.product_name, i.quantity
    FROM inventory i
    JOIN product p ON i.product_id = p.product_id
    ORDER BY p.product_name;
  `;

	const customerList: any = await prisma.$queryRaw`SELECT customer_name, credits FROM customer ORDER BY customer_name;`;

	return {
		total_sales: parseFloat(totalSales[0].total_sales),
		total_profit: parseFloat(totalProfit[0].total_profit),
		total_stock: parseInt(totalStock[0].total_stock),
		total_credits: parseFloat(totalCredits[0].total_credits),
		stockList,
		customerList,
	};
}

// === Send Email Report ===
export async function sendPOSReport(transporter: nodemailer.Transporter, REPORTS_DIR: string) {
	try {
		console.log("📧 Preparing email report...");
		const stats = await getPOSStats();
		const filePath = await generateDBBackup(REPORTS_DIR);
		const { total_sales, total_profit, total_stock, total_credits, stockList, customerList } = stats;

		// Build tables
		const stockRows = stockList
			.map((s: any) => `<tr><td>${s.product_id}</td><td>${s.product_name}</td><td>${s.quantity}</td></tr>`)
			.join("");

		const customerRows = customerList
			.map(
				(c: any) =>
					`<tr><td>${c.customer_name}</td><td>Rs. ${(parseFloat(c.credits) || 0).toFixed(2)}</td></tr>`
			)
			.join("");

		const subject = `POS Report: Sales Rs.${total_sales.toFixed(2)} | Profit Rs.${total_profit.toFixed(
			2
		)} | Stock ${total_stock} | Credits Rs.${total_credits.toFixed(2)}`;

		const html = (`
      <h2>Smart POS - Daily Report</h2>
      <p><b>Date:</b> ${new Date().toLocaleString()}</p>

      <h3>📈 Summary</h3>
      <table border="1" cellpadding="8" cellspacing="0">
        <tr><th>Metric</th><th>Value</th></tr>
        <tr><td>Total Sales</td><td>Rs. ${total_sales.toFixed(2)}</td></tr>
        <tr><td>Total Profit</td><td>Rs. ${total_profit.toFixed(2)}</td></tr>
        <tr><td>Total Stock</td><td>${total_stock}</td></tr>
        <tr><td>Total Customer Credits</td><td>Rs. ${total_credits.toFixed(2)}</td></tr>
      </table>

      <h3>📦 Product Stock Details</h3>
      <table border="1" cellpadding="6" cellspacing="0">
        <tr><th>Product ID</th><th>Product Name</th><th>Available Stock</th></tr>
        ${stockRows || "<tr><td colspan='3'>No products found</td></tr>"}
      </table>

      <h3>👥 Customer Credit Details</h3>
      <table border="1" cellpadding="6" cellspacing="0">
        <tr><th>Customer Name</th><th>Credit Balance</th></tr>
        ${customerRows || "<tr><td colspan='2'>No customers found</td></tr>"}
      </table>

      <p>The attached file contains the full database backup.</p>
    `);

		await transporter.sendMail({
			from: `"Smart POS" <${SCHEDULAR_EMAIL}>`,
			to: DEFAULT_RECEIVER_EMAIL,
			subject,
			html,
			attachments: [{ filename: path.basename(filePath), path: filePath }],
		});

		console.log("✅ Email sent successfully!");
	} catch (err) {
		console.error("❌ Email send failed:", err);
	}
}

// === Helper to schedule based on saved time ===
export function scheduleJob(time: string, transporter: nodemailer.Transporter, REPORTS_DIR: string): ScheduledTask {
	const [hour, minute] = time.split(":");
	const cronExp = `${minute} ${hour} * * *`;
	console.log(`🔁 Scheduling email job at ${time}`);
	return cron.schedule(cronExp, () => sendPOSReport(transporter, REPORTS_DIR));
}
