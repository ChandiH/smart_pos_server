import type { RequestHandler } from "express";
import Product from "../models/product.model";
import Inventory from "../models/inventory.model";
import fileHandler from "../utils/fileHandler";

type ProductModel = {
  getProducts: () => Promise<{ rows: unknown[] }>;
  getProduct: (id: string) => Promise<{ rows: unknown[] }>;
  addProduct: (
    name: string,
    description: string,
    categoryId: number | string,
    images: string[],
    buyingPrice: number | string,
    retailPrice: number | string,
    discount: number | string,
    supplierId: number | string,
    barcode: string
  ) => Promise<{ rows: unknown[] }>;
  deleteProduct: (id: string) => Promise<unknown>;
  updateProduct: (
    name: string,
    description: string,
    categoryId: number | string,
    buyingPrice: number | string,
    retailPrice: number | string,
    discount: number | string,
    supplierId: number | string,
    barcode: string,
    productImage: string[],
    id: string
  ) => Promise<{ rows: unknown[] }>;
  updateProductDiscount: (
    id: string,
    discount: number | string
  ) => Promise<unknown>;
  getProductWithCategory: () => Promise<{ rows: unknown[] }>;
  getProductsBySupplierId: (id: string) => Promise<{ rows: unknown[] }>;
  isBarcodeTaken: (barcode: string) => Promise<boolean>;
};

type InventoryModel = {
  getInventoryByProductId: (
    id: string
  ) => Promise<{ rows: Array<{ quantity: number }> }>;
};

type FileHandlerModule = {
  deleteImage: (imagePath: string) => void;
};

const productModel = Product as ProductModel;
const inventoryModel = Inventory as InventoryModel;
const { deleteImage } = fileHandler as FileHandlerModule;

const getProducts: RequestHandler = (_req, res) => {
  return productModel
    .getProducts()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getProduct: RequestHandler = (req, res) => {
  const { id } = req.params;
  return productModel
    .getProduct(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface AddProductBody {
  product_name: string;
  product_desc: string;
  category_id: number | string;
  buying_price: number | string;
  retail_price: number | string;
  discount: number | string;
  supplier_id: number | string;
  product_barcode: string;
}

const addProduct: RequestHandler<unknown, unknown, AddProductBody> = async (
  req,
  res
) => {
  const {
    product_name,
    product_desc,
    category_id,
    buying_price,
    retail_price,
    discount,
    supplier_id,
    product_barcode,
  } = req.body;

  console.log(req.body);
  console.log(req.files);

  try {
    const barcodeInUse = await productModel.isBarcodeTaken(product_barcode);
    const uploadedFiles = req.files as Express.Multer.File[] | undefined;

    if (barcodeInUse) {
      uploadedFiles?.forEach((file) => deleteImage(file.path));
      return res.status(400).json({
        error: { product_barcode: "Barcode is already exists in the system" },
      });
    }

    const images: string[] =
      uploadedFiles?.map((file) => file.filename) ?? [];

    const imagePlaceholder = [
      "product-image-placeholder.jpg",
      "placeholder-300x400.png",
      "placeholder-200x200.png",
    ];

    return productModel
      .addProduct(
        product_name,
        product_desc,
        category_id,
        images.length > 0 ? images : imagePlaceholder,
        buying_price,
        retail_price,
        discount,
        supplier_id,
        product_barcode
      )
      .then((data) => res.status(200).json(data.rows))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

const deleteProduct: RequestHandler = async (req, res) => {
  const { id: product_id } = req.params;

  try {
    const stock = await inventoryModel.getInventoryByProductId(product_id);
    const totalQuantity = stock.rows.reduce(
      (total, item) => total + (item.quantity ?? 0),
      0
    );

    console.log(totalQuantity);

    if (totalQuantity > 0) {
      return res.status(400).json({
        error: `Cannot delete product. There are ${totalQuantity} items in stock in all the branches.`,
      });
    }

    return productModel
      .deleteProduct(product_id)
      .then(() => res.status(200).json({ result: "successfully Deleted" }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

interface UpdateProductBody extends AddProductBody {
  product_image: string[];
}

const updateProduct: RequestHandler<unknown, unknown, UpdateProductBody> = (
  req,
  res
) => {
  const { id } = req.params;
  const {
    product_name,
    product_desc,
    category_id,
    buying_price,
    retail_price,
    discount,
    supplier_id,
    product_barcode,
    product_image,
  } = req.body;

  return productModel
    .updateProduct(
      product_name,
      product_desc,
      category_id,
      buying_price,
      retail_price,
      discount,
      supplier_id,
      product_barcode,
      product_image,
      id
    )
    .then((data) => {
      if (data.rows && data.rows.length > 0) {
        console.log(data.rows);
      }
      return res.status(200).json({ message: "Product updated successfully" });
    })
    .catch((err: unknown) => {
      console.error(err);
      const message = err instanceof Error ? err.message : "Update failed";
      return res.status(400).json({ error: message });
    });
};

interface UpdateDiscountBody {
  discount: number | string;
}

const updateProductDiscount: RequestHandler<
  unknown,
  unknown,
  UpdateDiscountBody
> = (req, res) => {
  const { id: product_id } = req.params;
  const { discount } = req.body;
  return productModel
    .updateProductDiscount(product_id, discount)
    .then(() =>
      res.status(200).json({ message: "Product updated successfull" })
    )
    .catch((err) => res.status(400).json({ error: err }));
};

const getProductsWithCategory: RequestHandler = (_req, res) => {
  return productModel
    .getProductWithCategory()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getProductsBySupplierId: RequestHandler = (req, res) => {
  const { id } = req.params;
  return productModel
    .getProductsBySupplierId(id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getProducts,
  getProduct,
  addProduct,
  deleteProduct,
  updateProduct,
  updateProductDiscount,
  getProductsWithCategory,
  getProductsBySupplierId,
};
