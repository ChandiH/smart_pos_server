const express = require("express");
const dotenv = require("dotenv");
const path = require("path");
const cors = require("cors");

// routes
const authRouter = require("./routes/auth.routes");
const branchRouter = require("./routes/branch.routes");
const cartRouter = require("./routes/cart.routes");
const customerRouter = require("./routes/customer.routes");
const employeeRouter = require("./routes/employee.routes");
const inventoryRouter = require("./routes/inventory.routes");
const productRouter = require("./routes/product.routes");
const categoryRouter = require("./routes/category.routes");
const chartRouter = require("./routes/chart.routes");
const supplierRouter = require("./routes/supplier.routes");
const userRoleRouter = require("./routes/userRole.routes");
// config
dotenv.config();
const PORT = process.env.PORT || 4000;

// middleware
const jwt = require("./middleware/authJWT");
const upload = require("./middleware/upload");

const app = express();

app.use(express.json());
// app.use(express.urlencoded());
app.use(cors());

app.use("/static/image", express.static(path.join(__dirname, "public/image")));
app.post("/upload", upload.single("file"), (req, res) => {
  return res
    .status(200)
    .json({ message: "File uploaded successfully!", file: req.file });
});
app.post("/upload-multiple", upload.array("files"), (req, res) => {
  return res
    .status(200)
    .json({ message: "Files uploaded successfully!", files: req.files });
});

app.use("/auth", authRouter);
app.use("/customer", customerRouter);
app.use("/employee", employeeRouter);
app.use("/product", upload.array("files"), productRouter);
app.use("/cart", cartRouter);
app.use("/inventory", inventoryRouter);
app.use("/branch", branchRouter);
app.use("/supplier", supplierRouter);
app.use("/chart", chartRouter);
app.use("/user-role", userRoleRouter);
// sample of jwt middleware
app.use("/customer", jwt.verifyToken, customerRouter);

process.env.TZ = 'Asia/Colombo';

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
