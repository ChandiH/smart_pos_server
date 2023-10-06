const Pool = require("pg").Pool;

const pool = new Pool({
  user: process.env.DATABASE_USER,
  database: process.env.DATABASE_NAME,
  host: process.env.DATABASE_HOST,
  port: process.env.DATABASE_PORT,
  password: process.env.DATABASE_PASSWORD,
  ssl: { rejectUnauthorized: false },
});

module.exports = pool;
