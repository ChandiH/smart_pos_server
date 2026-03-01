import type { RequestHandler } from "express";
import jwt, { type JwtPayload, type Secret } from "jsonwebtoken";
import { JWT_AUDIENCE, JWT_ISSUER, SECRET_KEY } from "../config/envs";

const extractToken = (tokenHeader: string | string[] | undefined): string | null => {
  if (!tokenHeader) return null;

  return Array.isArray(tokenHeader) ? tokenHeader[0] ?? null : tokenHeader;
};

const extractBearerToken = (authHeader: string | string[] | undefined): string | null => {
  const header = extractToken(authHeader);
  if (!header) return null;
  const [scheme, token] = header.split(" ");
  if (scheme?.toLowerCase() !== "bearer" || !token) return null;
  return token;
};

export const verifyToken: RequestHandler = (req, res, next) => {
  const token = extractBearerToken(req.headers.authorization) ?? extractToken(req.headers["x-access-token"]);

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

  jwt.verify(token, SECRET_KEY as Secret, { issuer: JWT_ISSUER, audience: JWT_AUDIENCE }, (err, decoded) => {
    if (err) {
      const isExpired = typeof err === "object" && err !== null && "name" in err && err.name === "TokenExpiredError";
      return res.status(401).json({
        message: isExpired ? "Token expired" : "Unauthorized",
        error: isExpired ? "TOKEN_EXPIRED" : "UNAUTHORIZED",
        logout: isExpired,
      });
    }

    res.locals.user = decoded as JwtPayload | string;
    next();
  });
};

export default { verifyToken };
