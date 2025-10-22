import { existsSync, unlinkSync } from "fs";

type DeleteImageResult =
  | { success: true; message: string }
  | { success: false; message: string };

const deleteImage = (imagePath: string): DeleteImageResult => {
  if (!existsSync(imagePath)) {
    return {
      success: false,
      message: "Image not found.",
    };
  }

  unlinkSync(imagePath);

  return {
    success: true,
    message: "Image deleted successfully!",
  };
};

const fileHandler = {
  deleteImage,
};

export { deleteImage };
export default fileHandler;
