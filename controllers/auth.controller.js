const Auth = require("../models/auth.model");
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
          return res.status(400).json({ error: "Invalid username/password" });
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
};
