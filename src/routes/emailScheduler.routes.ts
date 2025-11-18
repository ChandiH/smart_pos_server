import express, { Request, Response } from "express";
import nodemailer from "nodemailer";
import { ScheduledTask } from "node-cron";
import fs from "fs";
import { CONFIG_FILE, DEFAULT_SCHEDULE_TIME, EMAIL_PASSWORD, REPORTS_DIR, SCHEDULAR_EMAIL } from "../config/envs";
import { scheduleJob, sendPOSReport } from "../controllers/emailSchedular.controller";

const router = express.Router();

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,            // 587 for TLS, 465 for SSL
  secure: true,
  auth: {
    user: SCHEDULAR_EMAIL,
    pass: EMAIL_PASSWORD,
  },
    debug: true,
  logger: true
});

// Start with saved time
let scheduledTime = DEFAULT_SCHEDULE_TIME;
let currentSchedule: ScheduledTask = scheduleJob(scheduledTime, transporter, REPORTS_DIR);

// Get schedule
router.get("/get-schedule", (_req: Request, res: Response) => {
  res.json({ time: scheduledTime });
});

// Update schedule (persist + restart cron)
router.post("/set-schedule", (req: Request, res: Response) => {
  const { time } = req.body;

  if (!time || !/^\d{2}:\d{2}$/.test(time)) {
    return res.status(400).json({ success: false, message: "Invalid time format. Use HH:mm (24-hour)." });
  }

  try {
    // Save persistently
    fs.writeFileSync(CONFIG_FILE, JSON.stringify({ time }, null, 2));

    // Restart job
    currentSchedule.stop();
    currentSchedule = scheduleJob(time, transporter, REPORTS_DIR);
    scheduledTime = time;

    res.json({ success: true, message: `Schedule updated and saved for ${time}` });
  } catch (err: any) {
    res.status(500).json({ success: false, message: err.message });
  }
});

// Manual send now
router.post("/send-now", async (_req: Request, res: Response) => {
  console.log(SCHEDULAR_EMAIL, EMAIL_PASSWORD)
  await sendPOSReport(transporter, REPORTS_DIR);
  res.json({ success: true, message: "✅ Report sent manually!" });
});

export default router;
