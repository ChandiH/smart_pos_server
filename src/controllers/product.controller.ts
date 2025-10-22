import type { RequestHandler } from "express";
import fileHandler from "../utils/fileHandler";
import {
  addProduct,
  deleteProduct,
  getProduct,
  getProducts,
  getProductsBySupplierId,
  getProductWithCategory,
  isBarcodeTaken,
  updateProduct,
  updateProductDiscount,
} from "../models/product.model";
import { getInventoryByProductId } from "../models/inventory.model";

interface UpdateDiscountBody {
  discount: number | string;
}

interface UpdateProductBody extends AddProductBody {
  product_image: string[];
}

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

type FileHandlerModule = {
  deleteImage: (imagePath: string) => void;
};

const { deleteImage } = fileHandler as FileHandlerModule;

export const GetProducts: RequestHandler = async (_req, res) => {
  return await getProducts()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetProduct: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getProduct(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddProduct: RequestHandler<unknown, unknown, AddProductBody> = async (req, res) => {
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
    const barcodeInUse = await isBarcodeTaken(product_barcode);
    const uploadedFiles = req.files as Express.Multer.File[] | undefined;

    if (barcodeInUse) {
      uploadedFiles?.forEach((file) => deleteImage(file.path));
      return res.status(400).json({
        error: { product_barcode: "Barcode is already exists in the system" },
      });
    }

    const images: string[] = uploadedFiles?.map((file) => file.filename) ?? [];

    const imagePlaceholder = ["product-image-placeholder.jpg", "placeholder-300x400.png", "placeholder-200x200.png"];

    return await addProduct(
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
      .then((data) => res.status(200).json({ data }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

export const DeleteProduct: RequestHandler = async (req, res) => {
  const { id: product_id } = req.params;

  try {
    const stock = await getInventoryByProductId(product_id);
    const totalQuantity = stock.reduce((total, item) => total + (item.quantity ?? 0), 0);

    console.log(totalQuantity);

    if (totalQuantity > 0) {
      return res.status(400).json({
        error: `Cannot delete product. There are ${totalQuantity} items in stock in all the branches.`,
      });
    }

    return await deleteProduct(product_id)
      .then(() => res.status(200).json({ result: "successfully Deleted" }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

export const UpdateProduct: RequestHandler<any, unknown, UpdateProductBody> = async (req, res) => {
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

  return updateProduct(
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
    .then(() => {
      return res.status(200).json({ message: "Product updated successfully" });
    })
    .catch((err: unknown) => {
      console.error(err);
      const message = err instanceof Error ? err.message : "Update failed";
      return res.status(400).json({ error: message });
    });
};

export const UpdateProductDiscount: RequestHandler<any, unknown, UpdateDiscountBody> = async (req, res) => {
  const { id: product_id } = req.params;
  const { discount } = req.body;
  return await updateProductDiscount(product_id, discount)
    .then(() => res.status(200).json({ message: "Product updated successfully" }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetProductsWithCategory: RequestHandler = async (_req, res) => {
  return await getProductWithCategory()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetProductsBySupplierId: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getProductsBySupplierId(id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
