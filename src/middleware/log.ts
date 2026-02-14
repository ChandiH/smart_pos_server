import type { ErrorRequestHandler, RequestHandler } from "express";
import { attachTraceId, logError, logRequestFinish, logRequestStart } from "../utils/logger";

export const logRequest: RequestHandler = (req, res, next) => {
  const traceId = attachTraceId(req, res);
  const start = process.hrtime.bigint();
  logRequestStart(req, traceId);

  res.on("finish", () => {
    const durationMs = Number(process.hrtime.bigint() - start) / 1_000_000;
    logRequestFinish(req, res, traceId, durationMs);
  });

  next();
};

export const logErrors: ErrorRequestHandler = (err, req, res, next) => {
  const traceId = res.locals.trace_id ?? attachTraceId(req, res);
  const error = err instanceof Error ? err : new Error(String(err));
  logError(error, req, res, traceId);
  next(err);
};

export default { logRequest, logErrors };
