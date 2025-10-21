import express from "express";
import { getProduct, createProduct, updateProduct, deleteProduct } from "../controllers/productControllers.js";
import verifyAdmin from "../middleware/verifyAdmin.js";
import multer from "multer";
import path from "path";

const router = express.Router();

// === Setup Storage untuk Multer ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/"); // pastikan folder "uploads/" sudah ada
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  },
});

// === Filter file (opsional tapi disarankan) ===
const fileFilter = (req, file, cb) => {
  const allowedTypes = ["image/jpeg", "image/png", "image/jpg", "image/webp"];
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Format file tidak diizinkan. Hanya JPG, PNG, WEBP."));
  }
};

const upload = multer({ storage, fileFilter });

// === ROUTES ===
router.get("/", getProduct);
router.post("/", upload.array("images", 5), createProduct);
router.put("/:id", verifyAdmin, upload.array("images", 5), updateProduct);
router.delete("/:id", verifyAdmin, deleteProduct);

export default router;
