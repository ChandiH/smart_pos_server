import type { Request, Response } from "express";
import { randomUUID } from "crypto";

type LogLevel = "info" | "error";

const logLine = (level: LogLevel, message: string, meta: Record<string, unknown>) => {
  const payload = {
    timestamp: new Date().toISOString(),
    level,
    message,
    ...meta,
  };

  const line = JSON.stringify(payload);
  if (level === "error") {
    console.error(line);
    return;
  }

  console.log(line);
};

const getHandlerName = (req: Request) => {
  if (req.route?.path) {
    return `${req.baseUrl ?? ""}${req.route.path}`;
  }

  return req.originalUrl;
};

const getIncomingTraceId = (req: Request) => {
  const header = req.headers["x-trace-id"];
  if (typeof header === "string" && header.trim().length > 0) {
    return header;
  }

  if (Array.isArray(header) && header[0]?.trim()) {
    return header[0];
  }

  return randomUUID();
};

export const attachTraceId = (req: Request, res: Response) => {
  const trace_id = getIncomingTraceId(req);
  res.locals.trace_id = trace_id;
  res.setHeader("x-trace-id", trace_id);
  return trace_id;
};

export const logRequestStart = (req: Request, trace_id: string) => {
  logLine("info", "request.start", {
    trace_id,
    method: req.method,
    path: req.originalUrl,
    handler: getHandlerName(req),
    ip: req.ip,
    user_agent: req.headers["user-agent"],
  });
};

export const logRequestFinish = (req: Request, res: Response, trace_id: string, duration_ms: number) => {
  logLine("info", "request.finish", {
    trace_id,
    method: req.method,
    path: req.originalUrl,
    handler: getHandlerName(req),
    status_code: res.statusCode,
    duration_ms,
    content_length: res.getHeader("content-length"),
  });
};

export const logError = (err: Error, req: Request, res: Response, trace_id: string) => {
  logLine("error", "request.error", {
    trace_id,
    method: req.method,
    path: req.originalUrl,
    handler: getHandlerName(req),
    status_code: res.statusCode,
    error_message: err.message,
    error_stack: err.stack,
  });
};

export const logFunction = (function_name: string, trace_id: string, meta: Record<string, unknown> = {}) => {
  logLine("info", "function", {
    trace_id,
    function_name,
    ...meta,
  });
};
