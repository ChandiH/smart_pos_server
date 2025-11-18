import path from "path";
import fs from "fs";

export const DATABASE_URL = process.env.DATABASE_URL || "";

// Email Scheduler Configs
export const SCHEDULAR_EMAIL = process.env.SCHEDULAR_EMAIL || "";
export const EMAIL_PASSWORD = process.env.EMAIL_PASSWORD || "";
export const DEFAULT_RECEIVER_EMAIL = process.env.DEFAULT_RECEIVER_EMAIL || "";

// === CONFIG ===
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
