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
  const connectionLabel = `${printerIp}:${port}`;
  console.log("[printer] Starting print job", {
    connection: connectionLabel,
    lineCount: lines.length,
    cut,
    openDrawer,
  });
  const socket = new net.Socket();
  let socketEnded = false;
  try {
    await new Promise<void>((res, rej) => {
      const onError = (err: Error) => {
        console.error("[printer] Socket error during connection", { connection: connectionLabel, error: err });
        socket.removeListener("error", onError);
        rej(err);
      };
      socket.once("error", onError);
      socket.connect(port, printerIp, () => {
        socket.removeListener("error", onError);
        console.log("[printer] Connected to printer", { connection: connectionLabel });
        res();
      });
    });

    const write = (buf: Buffer) =>
      new Promise<void>((res, rej) =>
        socket.write(buf, (err) => {
          if (err) {
            console.error("[printer] Failed to write to socket", { connection: connectionLabel, error: err });
            rej(err);
          } else {
            res();
          }
        })
      );

    // ESC @ (init)
    await write(Buffer.from([0x1b, 0x40]));

    const enc = (s: string) => iconv.encode(s, "cp437"); // pick a code page your printer supports

    for (const [index, line] of lines.entries()) {
      if ("hr" in line) {
        console.log("[printer] Writing horizontal rule", { connection: connectionLabel, index });
        await write(enc("--------------------------------\n"));
        continue;
      }
      if ("text" in line) {
        const a = line.align === "C" ? 1 : line.align === "R" ? 2 : 0;
        console.log("[printer] Writing text line", {
          connection: connectionLabel,
          index,
          align: line.align ?? "L",
          bold: Boolean(line.bold),
          text: line.text,
        });
        await write(Buffer.from([0x1b, 0x61, a]));
        if (line.bold) await write(Buffer.from([0x1b, 0x45, 0x01]));
        await write(enc(line.text + "\n"));
        if (line.bold) await write(Buffer.from([0x1b, 0x45, 0x00]));
        continue;
      }
      if ("qrcode" in line) {
        console.log("[printer] Encountered QR code line (not implemented)", { connection: connectionLabel, index });
        continue;
      }
      if ("barcode" in line) {
        console.log("[printer] Encountered barcode line (not implemented)", { connection: connectionLabel, index });
      }
      // (QR/barcode blocks unchanged from your previous code)
    }

    if (openDrawer) {
      console.log("[printer] Triggering cash drawer", { connection: connectionLabel });
      await write(Buffer.from([0x1b, 0x70, 0x00, 0x32, 0x32])); // kick drawer
    }
    await write(Buffer.from("\n\n"));
    if (cut) {
      console.log("[printer] Sending cut command", { connection: connectionLabel });
      await write(Buffer.from([0x1d, 0x56, 0x01])); // partial cut
    }

    socket.end();
    socketEnded = true;
    console.log("[printer] Print job completed", { connection: connectionLabel });
  } catch (error) {
    console.error("[printer] Print job failed", { connection: connectionLabel, error });
    if (!socket.destroyed) {
      socket.destroy();
    }
    throw error;
  } finally {
    if (!socketEnded && !socket.destroyed) {
      socket.destroy();
    }
    console.log("[printer] Socket closed", {
      connection: connectionLabel,
      destroyed: socket.destroyed,
      ended: socketEnded,
    });
  }
}
