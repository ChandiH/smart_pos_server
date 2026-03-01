import bcrypt from "bcrypt";

const ROUNDS = 12; // 10–14 typical; higher = slower = stronger

export async function hashPassword(plain: string) {
  const salt = await bcrypt.genSalt(ROUNDS);
  return bcrypt.hash(plain, salt);
}

export async function verifyPassword(plain: string, hashed: string) {
  return bcrypt.compare(plain, hashed);
}
