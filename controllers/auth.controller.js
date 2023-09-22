const Auth = require("../models/auth.model");

const { isUsernameTaken,  register } = require("../models/auth.model");

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
          return res.status(400).json({ error: "Invalid username/password." });
        }
        // then get employee details 
        Employee.getEmployee(employee_id)
          .then((data) => {
            delete data.rows[0]["password"];
            // then generate token
            const token = jwt.sign(data.rows[0], process.env.SECRET_KEY, {
              algorithm: "HS256",
            });
            return res.status(200).json({ token: token });
          })
          .catch((err) => res.status(400).json({ error: err }));
      })
      .catch((err) => res.status(400).json({ error: err }));
  },

 

 async register(req, res, next) {
  const { employee_name, role_id, employee_email, employee_phone, branch_id,employee_image } = req.body;

  // Validate that all required fields are provided
  if ( !employee_name || !role_id || !employee_email || !employee_phone || !branch_id || !employee_image) {
    return res.status(400).json({ error: "All fields are required" });
  }

  // Check if the username is already taken
  const isUsernameInUse = await isUsernameTaken(employee_name);
  if (isUsernameInUse) {
    return res.status(400).json({ error: {employee_name: "User name is already taken."  }  }); 
  }

  try {
    

    // Call the register function to insert data into both tables
    const result = await register(employee_name, role_id, employee_email, employee_phone, branch_id,employee_image);

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


};