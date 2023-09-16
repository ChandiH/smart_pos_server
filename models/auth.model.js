const pool = require("../config/config");


const login = (username, password) => {
  return pool.query(
    "SELECT user_id as employee_id FROM  user_credentials WHERE username = $1 AND password = crypt($2, password)",
    [username, password]
  );
};

const register = (user_id,username, password) => {
  return pool.query(
    "INSERT INTO user_credentials (user_id,username, password) VALUES ($1,$2, crypt($3, gen_salt('bf')))",
    [user_id,username, password]
  );
};



// Check if the username is already in use
const isUsernameTaken = async (username) => {
  const result = await pool.query("SELECT 1 FROM user_credentials WHERE username = $1 LIMIT 1", [username]);
  return result.rowCount > 0;
};

// Check if the user_id is already in use
const isUserIdTaken = async (user_id) => {
  const result = await pool.query("SELECT 1 FROM user_credentials WHERE user_id = $1 LIMIT 1", [user_id]);
  return result.rowCount > 0;
};


module.exports = {
  login,
  register,
  isUsernameTaken,
  isUserIdTaken,
};
