import path from "path";
import fs from "fs";

export const SERVER_PORT = Number(process.env.PORT) || 4000;
export const SECRET_KEY = process.env.SECRET_KEY || "";
export const JWT_ISSUER = process.env.JWT_ISSUER || "smart-pos";
export const JWT_AUDIENCE = process.env.JWT_AUDIENCE || "smart-pos-client";
export const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || "8h";

export const DATABASE_URL = process.env.DATABASE_URL || "";
export const DATABASE_DOCKER = process.env.DATABASE_CONTAINER === "docker";

// Printer Configs
export const PRINTER_HOST = process.env.PRINTER_HOST || "127.0.0.1";
export const PRINTER_SHARE_NAME = process.env.PRINTER_SHARE_NAME || "POS_PRINTER"; // the Windows printer share name

// Email Scheduler Configs
export const SCHEDULAR_EMAIL = process.env.SCHEDULAR_EMAIL || "";
export const EMAIL_PASSWORD = process.env.EMAIL_PASSWORD || "";
export const DEFAULT_RECEIVER_EMAIL = process.env.DEFAULT_RECEIVER_EMAIL || "";

export let DEFAULT_SCHEDULE_TIME = "00:00"; // Default time
export const REPORTS_DIR = path.join(process.cwd(), "reports");
export const CONFIG_FILE = path.join(process.cwd(), "email_schedule.json");

if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR);

// === Load saved schedule time ===
if (fs.existsSync(CONFIG_FILE)) {
  try {
    const data = JSON.parse(fs.readFileSync(CONFIG_FILE, "utf8"));
    if (data.time && /^\d{2}:\d{2}$/.test(data.time)) {
      DEFAULT_SCHEDULE_TIME = data.time;
    }
  } catch (err) {
    console.error("⚠️ Could not load saved schedule, using default 00:00", err);
  }
}
