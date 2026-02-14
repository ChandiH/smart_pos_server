import type { RequestHandler } from "express";
import jwt from "jsonwebtoken";
import { getUserCredentialsByUsername, isUsernameTaken, register, resetPassword } from "../models/auth.model";
import { getEmployee } from "../models/employee.model";
import { verifyPassword } from "../utils/hash";
import { JWT_AUDIENCE, JWT_EXPIRES_IN, JWT_ISSUER, SECRET_KEY } from "../config/envs";

interface LoginBody {
  username: string;
  password: string;
}

interface RegisterBody {
  employee_name: string;
  employee_userName: string;
  role_id: string;
  employee_email: string;
  employee_phone: string;
  branch_id: string;
}

interface ResetPasswordBody {
  username: string;
  password: string;
  newPassword: string;
}

export const Login: RequestHandler<unknown, unknown, LoginBody> = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user_credentials = await getUserCredentialsByUsername(username);
    if (!user_credentials) {
      return res.status(400).json({ error: { username: "Invalid username." } });
    }

    const isPasswordValid = await verifyPassword(password, user_credentials.password);
    if (!isPasswordValid) {
      return res.status(400).json({ error: { username: "Invalid password." } });
    }

    const employee = await getEmployee(user_credentials.user_id);
    if (!employee) {
      return res.status(400).json({ error: { username: "Employee not found." } });
    }

    if (!SECRET_KEY) {
      console.error("SECRET_KEY is not defined in the environment.");
      return res.status(500).json({ error: "Internal server error" });
    }

    const token = jwt.sign(
      {
        employee_username: username,
        employee_id: employee.employee_id,
        employee_name: employee.employee_name,
        branch_id: employee.branch_id,
        branch_name: employee.branch.branch_city,
        role_id: employee.role_id,
        employee_image: employee.employee_image,
        role_name: employee.user_role.role_name,
        user_access: employee.user_role.user_access,
        employee_email: employee.employee_email,
        employee_phone: employee.employee_phone,
      },
      SECRET_KEY,
      {
        algorithm: "HS256",
        expiresIn: JWT_EXPIRES_IN,
        issuer: JWT_ISSUER,
        audience: JWT_AUDIENCE,
      }
    );

    return res.status(200).json({ token, token_type: "Bearer", expires_in: JWT_EXPIRES_IN });
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

export const RegisterUser: RequestHandler<unknown, unknown, RegisterBody> = async (req, res) => {
  const { employee_name, employee_userName, role_id, employee_email, employee_phone, branch_id } = req.body;

  if (!employee_name || !role_id || !employee_email || !employee_phone || !branch_id || !employee_userName) {
    return res.status(400).json({ error: { role_id: "All fields are required" } });
  }

  try {
    const isUsernameInUse = await isUsernameTaken(employee_userName);
    if (isUsernameInUse) {
      return res.status(400).json({
        error: { employee_userName: "User name is already taken." },
      });
    }

    const result = await register({
      employee_name,
      employee_userName,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
      employee_image: "employee-image-placeholder.jpg",
    });

    if (result) {
      return res.status(201).json({ message: "Registration successful" });
    }

    return res.status(400).json({ error: "Registration failed" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

export const ResetPasswordHandler: RequestHandler<unknown, unknown, ResetPasswordBody> = async (req, res) => {
  const { username, password, newPassword } = req.body;

  try {
    const isUsernameInUse = await isUsernameTaken(username);
    if (!isUsernameInUse) {
      return res.status(400).json({ error: { username: "User name is not exist." } });
    }

    const userCredentials = await getUserCredentialsByUsername(username);
    if (!userCredentials) {
      return res.status(400).json({ error: { username: "Invalid username." } });
    }

    const isCurrentPasswordValid = await verifyPassword(password, userCredentials.password);
    if (!isCurrentPasswordValid) {
      return res.status(400).json({ error: { password: "Invalid current password." } });
    }

    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
    if (!passwordRegex.test(newPassword)) {
      return res.status(400).json({
        error: {
          newPassword: "Password must be at least 6 characters long and contain at least one letter and one number",
        },
      });
    }

    const isPasswordSame = await verifyPassword(newPassword, userCredentials.password);
    if (isPasswordSame) {
      return res.status(400).json({ error: { newPassword: "Password same as previous." } });
    }

    const result = await resetPassword(userCredentials.user_id, newPassword);

    if (result) {
      return res.status(200).json({ message: "Reset password successful" });
    }

    return res.status(400).json({ error: "Reset password failed" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};
