const fs = require("fs");

function deleteImage(imagePath) {
  // Check if the image file exists.
  if (!fs.existsSync(imagePath)) {
    return {
      success: false,
      message: "Image not found.",
    };
  }
  // Delete the image file.
  fs.unlinkSync(imagePath);

  return {
    success: true,
    message: "Image deleted successfully!",
  };
}

module.exports = {
  deleteImage,
};
