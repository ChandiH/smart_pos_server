import type { RequestHandler } from "express";
import Category from "../models/category.model";

type CategoryModel = {
  getAllCategories: () => Promise<{ rows: unknown[] }>;
  getCategory: (id: string) => Promise<{ rows: unknown[] }>;
  addCategory: (categoryName: string) => Promise<{ rows: unknown[] }>;
  updateCategory: (id: string, categoryName: string) => Promise<{ rows: unknown[] }>;
};

const categoryModel = Category as CategoryModel;

const getCategories: RequestHandler = (_req, res) => {
  return categoryModel
    .getAllCategories()
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const getCategory: RequestHandler = (req, res) => {
  return categoryModel
    .getCategory(req.params.id)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

interface CategoryBody {
  category_name: string;
}

const addCategory: RequestHandler<unknown, unknown, CategoryBody> = (req, res) => {
  return categoryModel
    .addCategory(req.body.category_name)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

const updateCategory: RequestHandler<unknown, unknown, CategoryBody> = (req, res) => {
  return categoryModel
    .updateCategory(req.params.id, req.body.category_name)
    .then((data) => res.status(200).json(data.rows))
    .catch((err) => res.status(400).json({ error: err }));
};

export default {
  getCategories,
  getCategory,
  addCategory,
  updateCategory,
};
