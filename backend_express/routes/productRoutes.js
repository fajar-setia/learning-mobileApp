import express from "express";
import { getProduct, createProduct, updateProduct, deleteProduct } from "../controllers/productControllers.js";
import verifyAdmin from "../middleware/verifyAdmin.js";

const router = express.Router();

router.get("/" , getProduct);
router.post("/",verifyAdmin, createProduct);
router.put("/:id",verifyAdmin, updateProduct);
router.delete("/:id",verifyAdmin, deleteProduct);

export default router;