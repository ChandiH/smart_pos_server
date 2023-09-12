const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const cors = require("cors");
// routes
const customerRouter = require("./routes/customer.routes");
const employeeRouter = require("./routes/employee.routes");
const productRouter = require("./routes/product.routes");
const cartRouter = require("./routes/cart.routes");
const authRouter = require("./routes/auth.routes");
const inventoryRouter = require("./routes/inventory.routes");
dotenv.config();
const PORT = process.env.PORT || 4000;
// middleware
const jwt = require("./middleware/authJWT");

const app = express();

app.use(express.json());
// app.use(express.urlencoded());

app.use(cors());

app.use("/assets", express.static(path.join(__dirname, "public")));

app.use("/auth", authRouter);
app.use("/customer", customerRouter);
app.use("/employee", employeeRouter);
app.use("/product", productRouter);
app.use("/cart", cartRouter);
app.use("/inventory", inventoryRouter);

// sample of jwt middleware
// app.use("/customer", jwt.verifyToken, customerRouter);

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
