const pool = require("../config/config");

const login = (email, password) => {
  return pool.query(
    "select * from users WHERE email = $1 AND password = crypt($2, password)",
    [email, password]
  );
};

module.exports = {
  login,
};
