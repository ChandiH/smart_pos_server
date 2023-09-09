const express = require("express");
const {

createCart,
addProductToCart,
updateProductInCart,
getProductInCart,
getCurrentCart,
paymentCompleted,

} = require("../controllers/cart");
const router = express.Router();


router.post("/", createCart);
router.post("/add", addProductToCart);
router.put("/update/:id", updateProductInCart);
router.get("/:id", getProductInCart);
router.get("/current/:id", getCurrentCart);
router.put("/payment/:id", paymentCompleted);

module.exports = router;

