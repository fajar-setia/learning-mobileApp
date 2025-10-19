const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
  name: { type: String, required: true },
  slug: { type: String, unique: true },
  description: { type: String },
  price: { type: Number, required: true, min: 0 },
  comparePrice: { type: Number, min: 0 },
  category: { type: String, required: true }, // atau ObjectId jika pakai model Category
  petType: [{ type: String, enum: ['anjing', 'kucing', 'burung', 'ikan', 'hamster', 'kelinci', 'reptil'] }],
  brand: { type: String },
  weight: { type: Number }, // dalam gram
  unit: { type: String, enum: ['gr', 'kg', 'ml', 'l', 'pcs'] },
  stock: { type: Number, required: true, default: 0, min: 0 },
  images: [{ type: String }],
  tags: [String],
  rating: { type: Number, min: 0, max: 5, default: 0 },
  reviewCount: { type: Number, default: 0 },
  isAvailable: { type: Boolean, default: true }
}, {timestamps: true});

module.exports = mongoose.model('Product', productSchema);