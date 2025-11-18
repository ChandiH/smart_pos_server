import type { RequestHandler } from "express";
import { buildEscposBuffer, IPrintPayload, PrintPayload, sendRawToWindowsQueue } from "../services/printer.service";
import { PRINTER_SHARE_NAME } from "../config/envs";

const _linePrinter = async ({ lines, cut, openDrawer, codepage }: IPrintPayload) => {
  console.log("printing started", JSON.stringify({ lines, cut, openDrawer, codepage }));
  try {
    const buf = buildEscposBuffer(lines, { cut, openDrawer, codepage });
    await sendRawToWindowsQueue(buf, PRINTER_SHARE_NAME);
    return { ok: true };
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (e: any) {
    return { ok: false, error: e.message };
  }
};

export const PrintRaw: RequestHandler = async (req, res) => {
  try {
    const { lines, cut, openDrawer, codepage } = PrintPayload.parse(req.body);
    await _linePrinter({ lines, cut, openDrawer, codepage: codepage ?? "cp437" });
    res.json({ ok: true });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (e: any) {
    res.status(400).json({ ok: false, error: e.message });
  }
};

export const PrintReceipt: RequestHandler = async (req, res) => {
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

    console.log("[print-receipt] Sending to printer agent...");

    const resp = await _linePrinter({ lines, cut: true, openDrawer: false, codepage: "cp437" });

    if (!resp.ok) {
      throw new Error(`Print agent error: ${ resp.error}`);
    }

    console.log("[print-receipt] Successfully sent to printer agent");
    res.json(resp);
  } catch (err: any) {
    console.error("[print-receipt] Print job failed", err);
    res.status(500).json({ ok: false, error: err.message });
  }
};
