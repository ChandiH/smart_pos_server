const Auth = require("../models/auth.model");
const { register, isUsernameTaken, checkPassword, resetPassword } = require("../models/auth.model");



const Employee = require("../models/employee.model");
const jwt = require("jsonwebtoken");

module.exports = {
  async login(req, res, next) {
    const { username, password } = req.body;

    // check whether username and password are correct
    Auth.login(username, password)
      .then((data) => {
        // then get employee_id
        const employee_id = data.rows[0]?.employee_id;
        if (!employee_id) {
          return res
            .status(400)
            .json({ error: { username: "Invalid username/password." } });
        }
        // then get employee details
        Employee.getUserEmployee(employee_id)
          .then((data) => {
            const {
              employee_id,
              employee_name,
              branch_id,
              branch_name,
              role_id,
              employee_image,
              role_name,
              user_access,
              employee_email,
              employee_phone,
            } = data.rows[0];
            // then generate token
            const token = jwt.sign(
              {
                employee_username: username,
                employee_id,
                employee_name,
                branch_id,
                branch_name,
                role_id,
                employee_image,
                role_name,
                user_access,
                employee_email,
                employee_phone,
              },
              process.env.SECRET_KEY,
              {
                algorithm: "HS256",
              }
            );
            return res.status(200).json({ token: token });
          })
          .catch((err) => res.status(400).json({ error: err }));
      })
      .catch((err) => res.status(400).json({ error: err }));
  },

  async register(req, res, next) {
    const {
      employee_name,
      employee_userName,
      role_id,
      employee_email,
      employee_phone,
      branch_id,
      employee_image,
    } = req.body;

    // Validate that all required fields are provided
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

    // Check if the username is already taken
    const isUsernameInUse = await isUsernameTaken(employee_userName);
    if (isUsernameInUse) {
      return res
        .status(400)
        .json({ error: { employee_userName: "User name is already taken." } });
    }

    try {
      // Call the register function to insert data into both tables
      const result = await register({
        employee_name,
        employee_userName,
        role_id,
        employee_email,
        employee_phone,
        branch_id,
        employee_image,
      });

      if (result) {
        // Registration successful
        return res.status(201).json({ message: "Registration successful" });
      } else {
        // Registration failed
        return res.status(400).json({ error: "Registration failed" });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: "Internal server error" });
    }
  },

  //reset password only
  async resetPassword(req, res, next) {
    const { username, password } = req.body;
    // Validate that password has numbers and characters with length at least  6
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/; 
    if (!passwordRegex.test(password)) {
      return res.status(400).json({
        error: {
          password:"Password must be at least 6 characters long and contain at least one letter and one number",
        },
      });
    }
    // Check if the username is in the list
    const isUsernameInUse = await isUsernameTaken(username);
    if (!isUsernameInUse) {
      return res
        .status(400)
        .json({ error: { username: "User name is not exist." } });
    }
    //check password same as previous
    const isPasswordSame = await checkPassword(username, password);
    if (isPasswordSame) {
      return res
        .status(400)
        .json({ error: { password: "Password same as previous." } });
    }
    try {
      const result = await resetPassword(username, password);
      if (result) {
        return res.status(200).json({ message: "Reset password successful" });
      } else {
        return res.status(400).json({ error: "Reset password failed" });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: "Internal server error" });
    }
  }
};
