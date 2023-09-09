const Pool = require("pg").Pool;

const pool = new Pool({
  user: "postgres",
  database: "smart_pos_db",
  host: "localhost",
  port: 8088,
  password: "password",
});

module.exports = pool;
