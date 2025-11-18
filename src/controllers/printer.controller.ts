// printer.controller.ts
import type { RequestHandler } from "express";
import { buildEscposBuffer, sendRawToWindowsQueue } from "../services/printer.service";
import { buildReceiptFromSale } from "../services/receipt.builder";

const PRINTER_SHARE = process.env.PRINTER_SHARE || "POS_PRINTER";

export const PrintReciept: RequestHandler = async (req, res) => {
  console.log("Receipt build started");

  try {
    if (!req.body?.salesData) {
      return res.status(400).json({ ok: false, error: "Missing salesData" });
    }

    // Build the ESC/POS friendly receipt structure
    const payload = await buildReceiptFromSale(req.body.salesData);

    // Convert structures to raw printer bytes
    const buffer = buildEscposBuffer(payload.lines, {
      cut: payload.cut,
      openDrawer: payload.openDrawer,
      codepage: payload.codepage,
    });

    console.log("Sending to printer:", PRINTER_SHARE);

    await sendRawToWindowsQueue(buffer, PRINTER_SHARE);

    return res.json({ ok: true });
  } catch (e: any) {
    console.log("Print Error:", e);
    return res.status(400).json({ ok: false, error: e.message });
  }
};
