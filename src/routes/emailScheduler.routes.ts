import express, { Request, Response } from "express";
import nodemailer from "nodemailer";
import cron, { ScheduledTask } from "node-cron";
import { exec } from "child_process";
import fs from "fs";
import path from "path";
import { Client } from "pg";

const router = express.Router();

// === CONFIG ===
const DB_NAME = "smart_pos_db";
const DB_USER = "postgres";
const DB_PASSWORD = "199805";
const DB_HOST = "localhost";
const DB_PORT = 5432;
const REPORTS_DIR = path.join(process.cwd(), "reports");
const CONFIG_FILE = path.join(process.cwd(), "email_schedule.json");

if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR);

// === Load saved schedule time ===
let scheduledTime = "00:00"; // default midnight
if (fs.existsSync(CONFIG_FILE)) {
  try {
    const data = JSON.parse(fs.readFileSync(CONFIG_FILE, "utf8"));
    if (data.time && /^\d{2}:\d{2}$/.test(data.time)) {
      scheduledTime = data.time;
    }
  } catch (err) {
    console.error("⚠️ Could not load saved schedule, using default 00:00", err);
  }
}

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "poslaabakade@gmail.com",
    pass: "kphtqbtvviiwhipc", // Gmail App Password
  },
});

// === Database helper ===
async function queryDB(query: string) {
  const client = new Client({
    user: DB_USER,
    host: DB_HOST,
    database: DB_NAME,
    password: DB_PASSWORD,
    port: DB_PORT,
  });
  await client.connect();
  const res = await client.query(query);
  await client.end();
  return res.rows;
}

// === Backup function ===
async function generateDBBackup(): Promise<string> {
  return new Promise((resolve, reject) => {
    try {
      const files = fs.readdirSync(REPORTS_DIR);
      for (const file of files) {
        if (file.endsWith(".sql")) fs.unlinkSync(path.join(REPORTS_DIR, file));
      }

      const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
      const backupFilePath = path.join(REPORTS_DIR, `POS_Backup_${timestamp}.sql`);

      const command = `pg_dump -U ${DB_USER} -F p -f "${backupFilePath}" ${DB_NAME}`;
      exec(command, { env: { ...process.env, PGPASSWORD: DB_PASSWORD } }, (error) => {
        if (error) reject(error);
        else resolve(backupFilePath);
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

  const totalSales = await queryDB(`
    SELECT COALESCE(SUM(total_amount),0) AS total_sales
    FROM sales_history
    WHERE created_at >= '${startISO}' AND created_at <= '${endISO}';
  `);

  const totalProfit = await queryDB(`
    SELECT COALESCE(SUM(profit),0) AS total_profit
    FROM sales_history
    WHERE created_at >= '${startISO}' AND created_at <= '${endISO}';
  `);

  const totalStock = await queryDB("SELECT COALESCE(SUM(quantity),0) AS total_stock FROM inventory;");
  const totalCredits = await queryDB("SELECT COALESCE(SUM(credits),0) AS total_credits FROM customer;");

  const stockList = await queryDB(`
    SELECT i.product_id, p.product_name, i.quantity
    FROM inventory i
    JOIN product p ON i.product_id = p.product_id
    ORDER BY p.product_name;
  `);

  const customerList = await queryDB("SELECT customer_name, credits FROM customer ORDER BY customer_name;");

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
async function sendPOSReport() {
  try {
    console.log("📧 Preparing email report...");
    const stats = await getPOSStats();
    const filePath = await generateDBBackup();

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

    const html = `
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

      <p>The attached file contains the full database backup for <b>${DB_NAME}</b>.</p>
    `;

    await transporter.sendMail({
      from: '"Smart POS" <poslaabakade@gmail.com>',
      to: "sinethmalaka16@gmail.com",
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
function scheduleJob(time: string): ScheduledTask {
  const [hour, minute] = time.split(":");
  const cronExp = `${minute} ${hour} * * *`;
  console.log(`🔁 Scheduling email job at ${time}`);
  return cron.schedule(cronExp, sendPOSReport, { scheduled: true });
}

// Start with saved time
let currentSchedule: ScheduledTask = scheduleJob(scheduledTime);

// === API Endpoints ===

// Get schedule
router.get("/get-schedule", (_req: Request, res: Response) => {
  res.json({ time: scheduledTime });
});

// Update schedule (persist + restart cron)
router.post("/set-schedule", (req: Request, res: Response) => {
  const { time } = req.body;

  if (!time || !/^\d{2}:\d{2}$/.test(time)) {
    return res.status(400).json({ success: false, message: "Invalid time format. Use HH:mm (24-hour)." });
  }

  try {
    // Save persistently
    fs.writeFileSync(CONFIG_FILE, JSON.stringify({ time }, null, 2));

    // Restart job
    currentSchedule.stop();
    currentSchedule = scheduleJob(time);
    scheduledTime = time;

    res.json({ success: true, message: `Schedule updated and saved for ${time}` });
  } catch (err: any) {
    res.status(500).json({ success: false, message: err.message });
  }
});

// Manual send now
router.post("/send-now", async (_req: Request, res: Response) => {
  await sendPOSReport();
  res.json({ success: true, message: "✅ Report sent manually!" });
});

export default router;
