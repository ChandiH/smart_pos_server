import multer from "multer";
import type { Request } from "express";

type DestinationCallback = (error: Error | null, destination: string) => void;
type FileNameCallback = (error: Error | null, filename: string) => void;

const storage = multer.diskStorage({
  destination(_req: Request, _file: Express.Multer.File, cb: DestinationCallback) {
    cb(null, "public/image");
  },
  filename(_req: Request, file: Express.Multer.File, cb: FileNameCallback) {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const upload = multer({ storage });

export { storage };
export default upload;
