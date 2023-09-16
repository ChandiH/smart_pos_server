const Auth = require("../models/auth.model");

const { isUsernameTaken, isUserIdTaken,  register } = require("../models/auth.model");

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
    const { user_id, username, password } = req.body;

    // Validate that all required fields are provided
    if (!user_id || !username || !password) {
      return res.status(400).json({ error: "All fields are required" });
    }

    try {
      
      //Check  if user_id is in the employee table

     
      // Check if the user_id is already taken
      const isUserIdInUse = await isUserIdTaken(user_id);
      if (isUserIdInUse) {
        return res.status(400).json({ error: {user_id: "User ID is already in use."}});
      }

      // Check if the username is already taken
      const isUsernameInUse = await isUsernameTaken(username);
      if (isUsernameInUse) {
        return res.status(400).json({ error: {username: "User name is already taken."  }  }); 
      }

      

      // If both username and user_id are unique, proceed with registration
      const result = await register(user_id, username, password);

      if (result.rowCount === 1) {
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



 //password reset
 
  
    
};
