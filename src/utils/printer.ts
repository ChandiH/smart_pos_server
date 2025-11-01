// src/print/networkPrinter.ts
import net from "node:net";
import iconv from "iconv-lite";

type Line =
  | { text: string; align?: "L" | "C" | "R"; bold?: boolean }
  | { hr?: true }
  | { qrcode?: string }
  | { barcode?: string };

export async function printReceiptToNetwork(
  printerIp: string,
  port = 9100,
  lines: Line[],
  cut = true,
  openDrawer = false
) {
  const socket = new net.Socket();
  await new Promise<void>((res, rej) => {
    socket.connect(port, printerIp, res);
    socket.once("error", rej);
  });

  const write = (buf: Buffer) => new Promise<void>((res, rej) => socket.write(buf, (err) => (err ? rej(err) : res())));

  // ESC @ (init)
  await write(Buffer.from([0x1b, 0x40]));

  const enc = (s: string) => iconv.encode(s, "cp437"); // pick a code page your printer supports

  for (const line of lines) {
    if ("hr" in line) {
      await write(enc("--------------------------------\n"));
      continue;
    }
    if ("text" in line) {
      // align
      const a = line.align === "C" ? 1 : line.align === "R" ? 2 : 0;
      await write(Buffer.from([0x1b, 0x61, a]));
      if (line.bold) await write(Buffer.from([0x1b, 0x45, 0x01]));
      await write(enc(line.text + "\n"));
      if (line.bold) await write(Buffer.from([0x1b, 0x45, 0x00]));
    }
    // (QR/barcode blocks unchanged from your previous code)
  }

  if (openDrawer) {
    await write(Buffer.from([0x1b, 0x70, 0x00, 0x32, 0x32])); // kick drawer
  }
  await write(Buffer.from("\n\n"));
  if (cut) await write(Buffer.from([0x1d, 0x56, 0x01])); // partial cut

  socket.end();
}
