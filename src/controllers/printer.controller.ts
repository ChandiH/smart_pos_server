import type { RequestHandler } from "express";
import { buildEscposBuffer, PrintPayload, sendRawToWindowsQueue } from "../services/printer.service";

const PRINTER_SHARE = process.env.PRINTER_SHARE || "POS_PRINTER"; // the Windows printer share name

export const PrintReciept: RequestHandler = async (req, res) => {
  console.log("printing started", JSON.stringify(req.body));
  try {
    const { lines, cut, openDrawer, codepage } = PrintPayload.parse(req.body);
    const buf = buildEscposBuffer(lines, { cut, openDrawer, codepage });
    await sendRawToWindowsQueue(buf, PRINTER_SHARE);
    res.json({ ok: true });
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (e: any) {
    res.status(400).json({ ok: false, error: e.message });
  }
};
