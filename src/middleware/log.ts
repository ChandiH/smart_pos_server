import type { RequestHandler } from "express";

export const logRequest: RequestHandler = (req, _res, next) => {
  console.log(req.method, req.url);
  next();
};

export default { logRequest };
