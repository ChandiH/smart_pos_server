import type { RequestHandler } from "express";
import { addCategory, getAllCategories, getCategory, updateCategory } from "../models/category.model";

interface NewCategoryReqBody {
  category_name: string;
}

export const GetCategories: RequestHandler = async (_req, res) => {
  return getAllCategories()
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const GetCategoryByID: RequestHandler = async (req, res) => {
  return getCategory(req.params.id)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const AddNewCategory: RequestHandler<unknown, unknown, NewCategoryReqBody> = async (req, res) => {
  return addCategory(req.body.category_name)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};

export const UpdateCategoryByID: RequestHandler<any, any, NewCategoryReqBody> = async (req, res) => {
  return updateCategory(req.params.id, req.body.category_name)
    .then((data) => res.status(200).json({ data }))
    .catch((err) => res.status(400).json({ error: err }));
};
