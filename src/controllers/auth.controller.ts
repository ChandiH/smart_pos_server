import type { RequestHandler } from "express";
import jwt from "jsonwebtoken";
import Auth from "../models/auth.model";
import Employee from "../models/employee.model";

type AuthLoginRow = {
  employee_id?: number;
};

type EmployeeRow = {
  employee_id: number;
  employee_name: string;
  branch_id: number;
  branch_name: string;
  role_id: number;
  employee_image: string;
  role_name: string;
  user_access: unknown;
  employee_email: string;
  employee_phone: string;
};

type AuthModel = {
  login: (username: string, password: string) => Promise<{ rows: AuthLoginRow[] }>;
  register: (payload: RegisterPayload) => Promise<boolean>;
  isUsernameTaken: (username: string) => Promise<boolean>;
  checkPassword: (username: string, password: string) => Promise<boolean>;
  resetPassword: (username: string, password: string) => Promise<boolean>;
};

type EmployeeModel = {
  getUserEmployee: (id: number) => Promise<{ rows: EmployeeRow[] }>;
};

type RegisterPayload = {
  employee_name: string;
  employee_userName: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: number;
  employee_image: string;
};

const authModel = Auth as AuthModel;
const employeeModel = Employee as EmployeeModel;

interface LoginBody {
  username: string;
  password: string;
}

const login: RequestHandler<unknown, unknown, LoginBody> = async (req, res) => {
  const { username, password } = req.body;

  try {
    const authResult = await authModel.login(username, password);
    const employee_id = authResult.rows[0]?.employee_id;

    if (!employee_id) {
      return res
        .status(400)
        .json({ error: { username: "Invalid username/password." } });
    }

    const employeeResult = await employeeModel.getUserEmployee(employee_id);
    const employee = employeeResult.rows[0];

    if (!employee) {
      return res
        .status(400)
        .json({ error: { username: "Invalid username/password." } });
    }

    const secret = process.env.SECRET_KEY;

    if (!secret) {
      console.error("SECRET_KEY is not defined in the environment.");
      return res.status(500).json({ error: "Internal server error" });
    }

    const token = jwt.sign(
      {
        employee_username: username,
        employee_id: employee.employee_id,
        employee_name: employee.employee_name,
        branch_id: employee.branch_id,
        branch_name: employee.branch_name,
        role_id: employee.role_id,
        employee_image: employee.employee_image,
        role_name: employee.role_name,
        user_access: employee.user_access,
        employee_email: employee.employee_email,
        employee_phone: employee.employee_phone,
      },
      secret,
      {
        algorithm: "HS256",
      }
    );

    return res.status(200).json({ token });
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

interface RegisterBody {
  employee_name: string;
  employee_userName: string;
  role_id: number;
  employee_email: string;
  employee_phone: string;
  branch_id: number;
}

const registerUser: RequestHandler<unknown, unknown, RegisterBody> = async (
  req,
  res
) => {
  const {
    employee_name,
    employee_userName,
    role_id,
    employee_email,
    employee_phone,
    branch_id,
  } = req.body;

  if (
    !employee_name ||
    !role_id ||
    !employee_email ||
    !employee_phone ||
    !branch_id ||
    !employee_userName
  ) {
    return res
      .status(400)
      .json({ error: { role_id: "All fields are required" } });
  }

  try {
    const isUsernameInUse = await authModel.isUsernameTaken(employee_userName);
    if (isUsernameInUse) {
      return res.status(400).json({
        error: { employee_userName: "User name is already taken." },
      });
    }

    const result = await authModel.register({
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

interface ResetPasswordBody {
  username: string;
  password: string;
  newPassword: string;
}

const resetPasswordHandler: RequestHandler<
  unknown,
  unknown,
  ResetPasswordBody
> = async (req, res) => {
  const { username, password, newPassword } = req.body;

  try {
    const isUsernameInUse = await authModel.isUsernameTaken(username);
    if (!isUsernameInUse) {
      return res
        .status(400)
        .json({ error: { username: "User name is not exist." } });
    }

    const data = await authModel.login(username, password);
    const employee_id = data.rows[0]?.employee_id;
    if (!employee_id) {
      return res
        .status(400)
        .json({ error: { username: "Invalid username/password." } });
    }

    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
    if (!passwordRegex.test(newPassword)) {
      return res.status(400).json({
        error: {
          newPassword:
            "Password must be at least 6 characters long and contain at least one letter and one number",
        },
      });
    }

    const isPasswordSame = await authModel.checkPassword(
      username,
      newPassword
    );
    if (isPasswordSame) {
      return res
        .status(400)
        .json({ error: { newPassword: "Password same as previous." } });
    }

    const result = await authModel.resetPassword(username, newPassword);

    if (result) {
      return res.status(200).json({ message: "Reset password successful" });
    }

    return res.status(400).json({ error: "Reset password failed" });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Internal server error" });
  }
};

export default {
  login,
  register: registerUser,
  resetPassword: resetPasswordHandler,
};
