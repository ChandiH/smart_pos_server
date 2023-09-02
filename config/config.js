const Pool = require("pg").Pool;

const pool = new Pool({
  user: "postgres",
  database: "mvc_app",
  host: "localhost",
  port: 8088,
  password: "password",
});

module.exports = pool;
