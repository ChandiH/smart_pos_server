const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const customerRouter = require("./routes/customer");

dotenv.config();
const PORT = process.env.PORT || 4000;

const app = express();
app.use(express.json());
// app.use(express.urlencoded());

app.use("/assets", express.static(path.join(__dirname, "public")));

app.use("/customer", customerRouter);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

/* sample of combination of route,model and contoller
 *app.get("/", async (req, res) => {
 *  try {
 *     const customers = await pool.query("select * from customer");
 *     res.status(200);
 *     res.json(customers);
 *   } catch (e) {
 *     console.log(e);
 *   }
 *});
 */
