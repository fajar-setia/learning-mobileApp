// controllers/productController.js
const Product = require('../models/product');

// GET /api/products
const getProduct = async (req, res) => {
  try {
    const products = await Product.find(); 
    res.json(products);
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ message: error.message });
  }
};

// POST /api/products
const createProduct = async (req, res) => {
  try {
   
    const bodyData = Object.fromEntries(Object.entries(req.body));

    const imagePaths = req.files ? req.files.map((file) => file.path) : [];

    const newProduct = new Product({
      ...bodyData,
      images: imagePaths,
    });

    const savedProduct = await newProduct.save();

    console.log("✅ Produk berhasil disimpan:", savedProduct);
    return res.status(201).json({
      message: "Produk berhasil ditambahkan",
      product: savedProduct,
    });
  } catch (error) {
    console.error("❌ Error saat menyimpan produk:", error);
    return res.status(500).json({
      message: "Terjadi kesalahan di server",
      error: error.message,
    });
  }
};


// PUT /api/products/:id
const updateProduct = async (req, res) => {
  try {
    const updatedProduct = await Product.findByIdAndUpdate(
      req.params.id, 
      req.body,
      { new: true, runValidators: true }
    );
    if (!updatedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.json(updatedProduct);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// DELETE /api/products/:id
const deleteProduct = async (req, res) => {
  try {
    const deletedProduct = await Product.findByIdAndDelete(req.params.id); 
    if (!deletedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }
    res.json({ message: 'Product deleted' });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};


module.exports = {
  getProduct,
  createProduct,
  updateProduct,
  deleteProduct
};