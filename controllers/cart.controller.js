const Cart = require("../models/cart.model");

const  insertSalesData = async (req, res, next) => {
  try {
    const { salesData } = req.body;
    await Cart.insertSalesData(salesData);
    res.status(200).json({ message: "Sales data inserted successfully" });
  } catch (error) {
    console.error(error);
    res.status(400).json({ error: error.message });
  }
};

module.exports = {
  insertSalesData,
};
