// drawer.service.ts
import { sendRawToWindowsQueue } from "./printer.service";

/**
 * Default ESC/POS drawer command:
 *    ESC p m t1 t2
 *    m  -> pin (0 or 1)
 *    t1 -> on time (1–255)
 *    t2 -> off time (1–255)
 *
 * Common working pulse for Epson and clones:
 *    m  = 0
 *    t1 = 25 (≈ 50 ms)
 *    t2 = 250 (≈ 500 ms)
 */
const ESC = 0x1b;

export const buildDrawerPulse = (
  pin: 0 | 1 = 0,
  t1: number = 25,
  t2: number = 250
): Buffer => {
  return Buffer.from([ESC, 0x70, pin, t1, t2]);
};

/**
 * Some cheap printer firmware only opens drawer on:
 *   GS a 1
 * or
 *   BEL (0x07)
 *
 * So we optionally include a fallback if needed.
 */
const fallbackPulse = Buffer.from([0x1b, 0x07]);

/**
 * Send drawer pulse to printer queue.
 * Optional: you can disable fallback if it's unnecessary.
 */
export const sendDrawerPulse = async (useFallback = false) => {
  try {
    console.log("[drawer] Sending ESC/POS pulse...");

    const pulse = buildDrawerPulse();
    await sendRawToWindowsQueue(pulse);

    if (useFallback) {
      console.log("[drawer] Sending fallback pulse (for non-Epson printers)...");
      await sendRawToWindowsQueue(fallbackPulse);
    }

    console.log("[drawer] Pulse OK");
    return { ok: true };

  } catch (e: any) {
    console.error("[drawer] Pulse Error:", e);
    return { ok: false, error: e.message || "Unknown drawer error" };
  }
};