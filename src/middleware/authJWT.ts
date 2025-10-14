import type { RequestHandler } from "express";
import jwt, { type JwtPayload, type Secret } from "jsonwebtoken";

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

  const secret = process.env.SECRET_KEY;

  if (!secret) {
    console.error("SECRET_KEY is not defined in the environment.");
    return res.status(500).json({
      message: "Internal server error",
    });
  }

  jwt.verify(token, secret as Secret, (err, decoded) => {
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
