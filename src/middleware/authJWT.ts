import type { RequestHandler } from "express";
import jwt, { type JwtPayload, type Secret } from "jsonwebtoken";
import { SECRET_KEY } from "../config/envs";

const extractToken = (tokenHeader: string | string[] | undefined): string | null => {
  if (!tokenHeader) {
    return null;
  }

  return Array.isArray(tokenHeader) ? tokenHeader[0] ?? null : tokenHeader;
};

export const verifyToken: RequestHandler = (req, res, next) => {
  const token = extractToken(req.headers["x-access-token"]);

  if (!token) {
    return res.status(403).json({
      message: "No token provided",
    });
  }

  if (!SECRET_KEY) {
    console.error("SECRET_KEY is not defined in the environment.");
    return res.status(500).json({
      message: "Internal server error",
    });
  }

  jwt.verify(token, SECRET_KEY as Secret, (err, decoded) => {
    if (err) {
      return res.status(401).json({
        message: "Unauthorized",
      });
    }

    console.log("Accessing the server", decoded as JwtPayload | string);
    next();
  });
};

export default { verifyToken };
