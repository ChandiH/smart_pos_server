import type { RequestHandler } from "express";
// import fileHandler from "../utils/fileHandler";
import {
  addProduct,
  addProductVariants,
  addProductWithVariants,
  deleteProduct,
  deleteProductVariant,
  getProduct,
  getProducts,
  getProductsBySupplierId,
  getProductWithCategory,
  isBarcodeTaken,
  updateProduct,
  updateProductVariants,
} from "../models/product.model";
import { getInventoryByProductId } from "../models/inventory.model";
import { product, product_variants } from "../prisma";

type AddProductVariantsBody = {
  variants: Omit<product_variants, "variant_id">[];
};

type UpdateProductVariantsBody = {
  variants: product_variants[];
};

interface UpdateProductBody extends AddProductBody {
  product_image: string[];
}

type AddProductBody = Omit<product, "product_id" | "product_image" | "removed" | "created_at" | "updated_on">;

type AddProductWithVariantBody = AddProductBody & {
  variants: Omit<product_variants, "variant_id" | "product_id">[];
};

// type FileHandlerModule = {
//   deleteImage: (imagePath: string) => void;
// };

// const { deleteImage } = fileHandler as FileHandlerModule;

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
  const { product_name, product_desc, category_id, supplier_id, product_barcode, stock_type } = req.body;

  console.log(req.body);
  console.log(req.files);

  try {
    const barcodeInUse = await isBarcodeTaken(product_barcode);
    // const uploadedFiles = req.files as Express.Multer.File[] | undefined;

    if (barcodeInUse) {
      // uploadedFiles?.forEach((file) => deleteImage(file.path));
      return res.status(400).json({
        error: { product_barcode: "Barcode is already exists in the system" },
      });
    }

    // const images: string[] = uploadedFiles?.map((file) => file.filename) ?? [];

    // const imagePlaceholder = ["product-image-placeholder.jpg", "placeholder-300x400.png", "placeholder-200x200.png"];

    return await addProduct({
      product_name,
      product_desc,
      category_id,
      supplier_id,
      product_barcode,
      stock_type,
    })
      .then((data) => res.status(200).json({ data }))
      .catch((err) => res.status(400).json({ error: err }));
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

export const AddProductWithVariants: RequestHandler<unknown, unknown, AddProductWithVariantBody> = async (req, res) => {
  const { product_name, product_desc, category_id, supplier_id, product_barcode, stock_type, variants } = req.body;

  console.log(req.body);
  console.log(req.files);

  try {
    const barcodeInUse = await isBarcodeTaken(product_barcode);

    if (barcodeInUse) {
      return res.status(400).json({
        error: { product_barcode: "Barcode is already exists in the system" },
      });
    }

    const response = await addProductWithVariants(
      {
        product_name,
        product_desc,
        category_id,
        supplier_id,
        product_barcode,
        stock_type,
      },
      variants
    );

    return res.status(200).json({ data: response });
  } catch (error) {
    console.error(error);
    return res.status(400).json({ error });
  }
};

export const DeleteProduct: RequestHandler = async (req, res) => {
  const { id: product_id } = req.params;

  try {
    const stock = await getInventoryByProductId(product_id);
    const totalQuantity = stock?.inventory.reduce((total, item) => total + (item.quantity ?? 0), 0);

    console.log(totalQuantity);

    if (totalQuantity && totalQuantity > 0) {
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
  const { product_name, product_desc, category_id, supplier_id, product_barcode, product_image, stock_type } = req.body;

  return updateProduct(id, {
    product_name,
    product_desc,
    category_id,
    supplier_id,
    product_barcode,
    product_image,
    stock_type,
  })
    .then(() => {
      return res.status(200).json({ message: "Product updated successfully" });
    })
    .catch((err: unknown) => {
      console.error(err);
      const message = err instanceof Error ? err.message : "Update failed";
      return res.status(400).json({ error: message });
    });
};

export const GetProductsWithCategory: RequestHandler = async (_req, res) => {
  return await getProductWithCategory()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetProductsBySupplierId: RequestHandler = async (req, res) => {
  const { id } = req.params;
  return await getProductsBySupplierId(Number(id))
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

// Product Variants Controllers
export const AddProductVariants: RequestHandler<unknown, unknown, AddProductVariantsBody> = async (req, res) => {
  const { variants } = req.body;
  return await addProductVariants(variants)
    .then(() => res.status(200).json({ message: "Product variants updated successfully" }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateProductVariants: RequestHandler<unknown, unknown, UpdateProductVariantsBody> = async (req, res) => {
  const { variants } = req.body;
  return await updateProductVariants(variants)
    .then(() => res.status(200).json({ message: "Product variants updated successfully" }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const DeleteProductVariants: RequestHandler<any, unknown, UpdateProductVariantsBody> = async (req, res) => {
  const { id: variant_id } = req.params;
  return await deleteProductVariant(variant_id)
    .then(() => res.status(200).json({ message: "Product variants updated successfully" }))
    .catch((err) => res.status(400).json({ error: err }));
};
