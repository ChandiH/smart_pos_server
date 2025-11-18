import express, { type Router } from "express";
import dotenv from "dotenv";
import path from "path";
import cors from "cors";
// config
dotenv.config();
const PORT = Number(process.env.PORT) || 4000;

// routes
import authRouter from "./routes/auth.routes";
import branchRouter from "./routes/branch.routes";
import cartRouter from "./routes/cart.routes";
import customerRouter from "./routes/customer.routes";
import employeeRouter from "./routes/employee.routes";
import inventoryRouter from "./routes/inventory.routes";
import productRouter from "./routes/product.routes";
import categoryRouter from "./routes/category.routes";
import chartRouter from "./routes/chart.routes";
import supplierRouter from "./routes/supplier.routes";
import userRoleRouter from "./routes/userRole.routes";
import printerRouter from "./routes/printer.route";
import emailSchedulerRouter from "./routes/emailScheduler.routes";

const simpleRoutes: Array<[string, Router]> = [
  ["/cart", cartRouter],
  ["/inventory", inventoryRouter],
  ["/branch", branchRouter],
  ["/supplier", supplierRouter],
  ["/chart", chartRouter],
  ["/user-role", userRoleRouter],
  ["/category", categoryRouter],
];

// middleware
import { logRequest } from "./middleware/log";
import { verifyToken } from "./middleware/authJWT";
import upload from "./middleware/upload";
import prisma from "./config/prisma";

const app = express();

app.use(express.json());
// app.use(express.urlencoded());
app.use(cors());

app.set("trust proxy", true);

app.use(logRequest);

app.use("/static", express.static(path.join(__dirname, "public")));
app.use("/static/image", express.static(path.join(__dirname, "public/image")));
app.post("/upload", upload.single("file"), (req, res) => {
  return res.status(200).json({ message: "File uploaded successfully!", file: req.file });
});
app.post("/upload-multiple", upload.array("files"), (req, res) => {
  return res.status(200).json({ message: "Files uploaded successfully!", files: req.files });
});

app.get("/health", (_req, res) => res.json({ ok: true }));
app.use("/print", printerRouter);
app.use("/email", emailSchedulerRouter);
app.use("/auth", authRouter);
app.use("/customer", customerRouter);
app.use("/employee", upload.single("file"), employeeRouter);
app.use("/product", upload.array("files"), productRouter);
app.use("/customer", verifyToken, customerRouter);

simpleRoutes.forEach(([path, router]) => {
  app.use(path, router);
});

prisma
  .$connect()
  .then(async () => {
    console.log("✅ Connected to the database via Prisma");
    const time = new Date().toUTCString();
    console.log(`🕒 Server started at ${time}`);
    app.listen(PORT, async () => {
      console.log(`🚀 Server running on http://localhost:${PORT}`);
    });
  })
  .catch((err: any) => {
    console.error("❌ Prisma connection error:", err);
});
