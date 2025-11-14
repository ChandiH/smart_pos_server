import express, { type Router } from "express";
import dotenv from "dotenv";
import path from "path";
import cors from "cors";
// config
dotenv.config();
const PORT = Number(process.env.PORT) || 4000;

// routes
import authRouter from "./routes/auth.routes";
import branchRouter from "./routes/branch.routes";
import cartRouter from "./routes/cart.routes";
import customerRouter from "./routes/customer.routes";
import employeeRouter from "./routes/employee.routes";
import inventoryRouter from "./routes/inventory.routes";
import productRouter from "./routes/product.routes";
import categoryRouter from "./routes/category.routes";
import chartRouter from "./routes/chart.routes";
import supplierRouter from "./routes/supplier.routes";
import userRoleRouter from "./routes/userRole.routes";
import emailSchedulerRouter from "./routes/emailScheduler.routes";

const simpleRoutes: Array<[string, Router]> = [
  ["/cart", cartRouter],
  ["/inventory", inventoryRouter],
  ["/branch", branchRouter],
  ["/supplier", supplierRouter],
  ["/chart", chartRouter],
  ["/user-role", userRoleRouter],
  ["/category", categoryRouter],
];

// middleware
import { logRequest } from "./middleware/log";
import { verifyToken } from "./middleware/authJWT";
import upload from "./middleware/upload";
import prisma from "./config/prisma";
import { printReceiptToNetwork } from "./utils/printer";

const app = express();

app.use(express.json());
// app.use(express.urlencoded());
app.use(cors());

prisma
  .$connect()
  .then(() => {
    console.log("✅ Connected to the database via Prisma");
  })
  .catch((err) => {
    console.error("❌ Prisma connection error:", err);
  });

app.use(logRequest);

app.use("/static", express.static(path.join(__dirname, "public")));
app.use("/static/image", express.static(path.join(__dirname, "public/image")));
app.post("/upload", upload.single("file"), (req, res) => {
  return res.status(200).json({ message: "File uploaded successfully!", file: req.file });
});
app.post("/upload-multiple", upload.array("files"), (req, res) => {
  return res.status(200).json({ message: "Files uploaded successfully!", files: req.files });
});

app.use("/email", emailSchedulerRouter);
app.use("/auth", authRouter);
app.use("/customer", customerRouter);
app.use("/employee", upload.single("file"), employeeRouter);
app.use("/product", upload.array("files"), productRouter);

app.post("/print-receipt", async (req, res) => {
  try {
    const { ip = "192.168.1.90", port = 9100, receipt } = req.body ?? {};
    const lineCount = Array.isArray(receipt?.lines) ? receipt.lines.length : 0;
    console.log("[print-receipt] Request received", {
      ip,
      port,
      openDrawer: receipt?.openDrawer ?? false,
      lineCount,
      hasReceipt: Boolean(receipt),
    });
    if (!receipt || !Array.isArray(receipt.lines)) {
      console.warn("[print-receipt] Invalid receipt payload", { receipt });
      return res.status(400).json({ ok: false, error: "Invalid receipt payload" });
    }
    console.log("[print-receipt] Sending receipt to printer", { ip, port });
    await printReceiptToNetwork(ip, port, receipt.lines, true, receipt.openDrawer);
    console.log("[print-receipt] Print job finished", { ip, port });
    res.json({ ok: true });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (e: any) {
    console.error("[print-receipt] Print job failed", { error: e, message: e?.message });
    res.status(500).json({ ok: false, error: e.message });
  }
});

simpleRoutes.forEach(([path, router]) => {
  app.use(path, router);
});
// sample of jwt middleware
app.use("/customer", verifyToken, customerRouter);

// 🖨️ Print Receipt route (via printer agent)
app.post("/print-receipt-02", async (req, res) => {
  try {
    const { salesData } = req.body ?? {};
    if (!salesData || !salesData.order || !salesData.products) {
      console.warn("[print-receipt] Invalid payload", { salesData });
      return res.status(400).json({ ok: false, error: "Invalid sales data" });
    }

    const order = salesData.order;
    const products = salesData.products;

    const lines = [
      { text: "SMART POS", align: "C", bold: true },
      { text: "------------------------------" },
      ...products.map((p: any) => ({
        text: `${p.product_name || p.product_id}  x${p.quantity}  ₱${p.price?.toFixed(2) || "0.00"}`,
      })),
      { text: "------------------------------" },
      { text: `TOTAL: ₱${order.total_amount}`, align: "R", bold: true },
      { text: `Payment: ${order.payment_method}`, align: "R" },
      { text: `Ref: ${order.reference}`, align: "R" },
      { hr: true },
      { text: "Thank you for your purchase!", align: "C" },
    ];

    console.log("[print-receipt] Sending to local printer agent...");
    const resp = await fetch("http://127.0.0.1:3333/print-raw", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        lines,
        cut: true,
        openDrawer: order.payment_method === "cash",
      }),
    });

    if (!resp.ok) {
      const text = await resp.text();
      throw new Error(`Print agent error: ${text}`);
    }

    console.log("[print-receipt] Successfully sent to printer agent");
    res.json({ ok: true });
  } catch (err: any) {
    console.error("[print-receipt] Print job failed", err);
    res.status(500).json({ ok: false, error: err.message });
  }
});

// 🩺 Printer Agent Health Check
async function checkPrinterAgent() {
  try {
    const res = await fetch("http://127.0.0.1:3333/health");
    if (res.ok) {
      const data = await res.json();
      if (data.ok) {
        console.log("🟢 Printer agent connected at http://127.0.0.1:3333");
        return true;
      }
    }
    console.warn("🟠 Printer agent responded but not OK:", await res.text());
    return false;
  } catch (err) {
    console.warn("🔴 Printer agent not reachable at http://127.0.0.1:3333");
    console.warn("   → Please run:  pnpm tsx src/printer-agent.ts");
    return false;
  }
}

// ✅ Start server once, with printer-agent check
prisma
  .$connect()
  .then(async () => {
    console.log("✅ Connected to the database via Prisma");
    app.listen(PORT, async () => {
      console.log(`🚀 Server running on http://localhost:${PORT}`);
      await checkPrinterAgent();
    });
  })
  .catch((err) => {
    console.error("❌ Prisma connection error:", err);
});
