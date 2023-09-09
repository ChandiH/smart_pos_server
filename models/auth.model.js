const pool = require("../config/config");

// "select * from employee WHERE username = $1 AND password = crypt($2, password)",

const login = (username, password) => {
  return pool.query(
    "select * from employee WHERE username = $1 AND password = crypt($2, password)",
    [username, password]
  );
};

module.exports = {
  login,
};
