const pool = require("../config/config");


const login = (username, password) => {
  return pool.query(
    "SELECT user_id as employee_id FROM  user_credentials WHERE username = $1 AND password = crypt($2, password)",
    [username, password]
  );
};




const register = async ( employee_name, role_id, employee_email, employee_phone, branch_id) => {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Insert data into the employee table
    const employeeResult = await client.query(
      'INSERT INTO employee (employee_name, role_id, employee_email, employee_phone, branch_id) VALUES ($1, $2, $3, $4, $5) RETURNING employee_id',
      [employee_name, role_id, employee_email, employee_phone, branch_id]
    );

    const employee_id = employeeResult.rows[0].employee_id;

    // Insert data into the user_credentials table
    const userCredentialsResult = await client.query(
      'INSERT INTO user_credentials (user_id, username, password) VALUES ($1, $2, crypt($3, gen_salt(\'bf\')))',
      [employee_id, employee_name, employee_name]
    );

    await client.query('COMMIT');
    return true; // Registration successful
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
};





// Check if the username is already in use
const isUsernameTaken = async (username) => {
  const result = await pool.query("SELECT 1 FROM user_credentials WHERE username = $1 LIMIT 1", [username]);
  return result.rowCount > 0;
};

// Check if the user_id is already in use
// const isUserIdTaken = async (user_id) => {
//   const result = await pool.query("SELECT 1 FROM user_credentials WHERE user_id = $1 LIMIT 1", [user_id]);
//   return result.rowCount > 0;
// };





module.exports = {
  login,
  register,
  isUsernameTaken,
  //isUserIdTaken,
};
