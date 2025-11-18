// printer.controller.ts
import type { RequestHandler } from "express";
import { buildEscposBuffer, sendRawToWindowsQueue, IPrintPayload, PrintPayload } from "../services/printer.service";
import { buildReceiptFromSale } from "../services/receipt.builder";
import { PRINTER_SHARE_NAME } from "../config/envs";

const _linePrinter = async ({ lines, cut, openDrawer, codepage }: IPrintPayload) => {
  console.log(`[printing started] ${PRINTER_SHARE_NAME}`, JSON.stringify({ lines, cut, openDrawer, codepage }));
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
    console.log("Print Error:", e);
    return res.status(400).json({ ok: false, error: e.message });
  }
};

export const PrintReciept: RequestHandler = async (req, res) => {
  console.log("Receipt build started");

  try {
    if (!req.body?.salesData) {
      return res.status(400).json({ ok: false, error: "Missing salesData" });
    }

    // Build the ESC/POS friendly receipt structure
    const payload: IPrintPayload = await buildReceiptFromSale(req.body.salesData);

    const response = await _linePrinter(payload);
    if (!response.ok) {
      return res.status(500).json(response);
    }
    return res.json({ ok: true });
  } catch (e: any) {
    console.log("Print Error:", e);
    return res.status(400).json({ ok: false, error: e.message });
  }
};
