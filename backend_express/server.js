import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv";
import productRoutes from "./routes/productRoutes.js"
import multer from "multer";


dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());
app.use("/uploads", express.static("uploads"));


mongoose.connect(process.env.MONGO_URI)
.then(() => console.log("MongoDB Connect"))
.catch((err) => console.error("connecction Error:", err));

//route
app.get("/", (res, req) => {
    try {
     res.send("🐾 Petshop API is running...");
  } catch (err) {
    
    res.status(500).json({ error: err.message });
  }
});


//route produk
app.use("/api/products", productRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));


