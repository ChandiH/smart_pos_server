import type { RequestHandler } from "express";
import { addCategory, getAllCategories, getCategory, updateCategory } from "../models/category.model";

export const getCategories: RequestHandler = async (_req, res) => {
  return getAllCategories()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const getCategoryByID: RequestHandler = async (req, res) => {
  return getCategory(req.params.id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

interface NewCategoryReqBody {
  category_name: string;
}

export const addNewCategory: RequestHandler<unknown, unknown, NewCategoryReqBody> = async (req, res) => {
  return addCategory(req.body.category_name)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const updateCategoryByID: RequestHandler<any, any, NewCategoryReqBody> = async (req, res) => {
  return updateCategory(req.params.id, req.body.category_name)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
