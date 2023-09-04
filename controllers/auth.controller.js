const Auth = require("../models/auth.model");
const jwt = require("jsonwebtoken");

module.exports = {
  async login(req, res, next) {
    const { email, password } = req.body;
    const data = await Auth.login(email, password)
      .then((data) => data)
      .catch((err) => res.status(400).json({ error: err }));
    if (!data.rows[0]) {
      return res.status(400).json({ error: "user not find" });
    }
    const user = { ...data.rows[0] };
    delete user["password"];
    const token = await jwt.sign(user, process.env.SECRET_KEY, {
      algorithm: "HS256",
    });

    return res.status(200).json({ token: token });
  },
};
