import fs from "node:fs/promises";
import path from "node:path";
import os from "node:os";
import { spawn } from "node:child_process";
import iconv from "iconv-lite";
import z from "zod";

/**
 * Simple ESC/POS line schema
 */
const LineSchema = z.union([
  z.object({ text: z.string(), align: z.enum(["L", "C", "R"]).optional(), bold: z.boolean().optional() }),
  z.object({ hr: z.literal(true) }),
  z.object({ qrcode: z.string() }),
  z.object({ barcode: z.string() }),
]);

export const PrintPayload = z.object({
  lines: z.array(LineSchema),
  cut: z.boolean().optional().default(true),
  openDrawer: z.boolean().optional().default(false),
  codepage: z.string().optional().default("cp437"),
});

export type IPrintPayload = z.infer<typeof PrintPayload>;

/** ----- ESC/POS builder ----- */
export function buildEscposBuffer(
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  lines: any[],
  opts: { cut: boolean; openDrawer: boolean; codepage: string }
): Buffer {
  const chunks: Buffer[] = [];

  // Initialize
  chunks.push(Buffer.from([0x1b, 0x40])); // ESC @

  for (const line of lines) {
    if (line && typeof line === "object" && Buffer.isBuffer((line as any).raw)) {
      chunks.push((line as any).raw);
      continue;
    }
    if ("hr" in line) {
      chunks.push(encode("------------------------------------------------\n", opts.codepage));
      continue;
    } 
    
    if ("qrcode" in line) {
      const data = Buffer.from(line.qrcode, "utf8");
      // Model 2, size 5, ECC M – adjust if needed
      chunks.push(Buffer.from([0x1d, 0x28, 0x6b, 3, 0, 0x31, 0x43, 0x05])); // size
      chunks.push(Buffer.from([0x1d, 0x28, 0x6b, 3, 0, 0x31, 0x45, 0x30])); // ECC M
      chunks.push(
        Buffer.from([0x1d, 0x28, 0x6b, (data.length + 3) & 0xff, ((data.length + 3) >> 8) & 0xff, 0x31, 0x50, 0x30])
      );
      chunks.push(data);
      chunks.push(Buffer.from([0x1d, 0x28, 0x6b, 3, 0, 0x31, 0x51, 0x30])); // print
      chunks.push(Buffer.from("\n"));
      continue;
    }
    if ("barcode" in line) {
      const data = Buffer.from(line.barcode, "ascii");
      chunks.push(Buffer.from([0x1d, 0x48, 0x02])); // HRI below
      chunks.push(Buffer.from([0x1d, 0x66, 0x00])); // font A
      chunks.push(Buffer.from([0x1d, 0x68, 0x50])); // height
      chunks.push(Buffer.from([0x1d, 0x6b, 0x49, data.length])); // CODE128
      chunks.push(data);
      chunks.push(Buffer.from("\n"));
      continue;
    }
    if ("text" in line) {
      const align = line.align === "C" ? 1 : line.align === "R" ? 2 : 0;
      chunks.push(Buffer.from([0x1b, 0x61, align]));
      if (line.bold) chunks.push(Buffer.from([0x1b, 0x45, 0x01]));
      chunks.push(encode(line.text + "\n", opts.codepage));
      if (line.bold) chunks.push(Buffer.from([0x1b, 0x45, 0x00]));
    }
  }

  if (opts.openDrawer) {
    // Kick cash drawer (pin 2)
    chunks.push(Buffer.from([0x1b, 0x70, 0x00, 0x32, 0x32]));
  }

  // Feed and cut
  chunks.push(Buffer.from("\n\n"));
  if (opts.cut) chunks.push(Buffer.from([0x1d, 0x56, 0x01])); // partial cut

  return Buffer.concat(chunks);

  function encode(s: string, cp = opts.codepage) {
    return iconv.encode(s, cp);
  }
}

/** ----- Windows queue sender (no native deps) ----- */
export async function sendRawToWindowsQueue(buf: Buffer, shareName: string) {
  // 1) Write to a temp .bin file
  const tmp = path.join(os.tmpdir(), `pos-${Date.now()}.bin`);
  await fs.writeFile(tmp, buf);

  // 2) Use `copy /b` to the local shared printer queue
  // Example: copy /b "C:\Temp\pos-123.bin" "\\127.0.0.1\XP80"
  await new Promise<void>((resolve, reject) => {
    const printerPath = `\\\\${process.env.PRINTER_HOST || '127.0.0.1'}\\${shareName}`;
    console.log("PRINT PATH:", printerPath);
    const p = spawn("cmd.exe", ["/c", "copy", "/b", tmp, printerPath], {
      windowsHide: true,
    });
    let stderr = "";
    p.stderr?.on("data", (d) => (stderr += d.toString()));
    p.on("exit", (code) => {
      // Clean up file
      fs.unlink(tmp).catch(() => {});
      if (code === 0) resolve();
      else reject(new Error(`copy failed with code ${code}: ${stderr}`));
    });
  });
}
