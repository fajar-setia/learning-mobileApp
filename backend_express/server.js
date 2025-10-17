import express from 'express';
import path from 'path';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import cors from 'cors';
import pool from './db_pakaian.js';

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

// Path setup
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Serve static React build (opsional)
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', (req, res) => {
  res.send('✅ Backend Express is running with PostgreSQL');
});

app.get('/products', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM products ORDER BY id ASC');
    console.log('✅ products fetched:', result.rows);
    res.json(result.rows);
  } catch (err) {
    console.error('❌ Error fetching products:', err.stack);
    res.status(500).json({ error: err.message });
  }
});


// Start server
const PORT = process.env.PORT || 8080;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server is running on port ${PORT}`);
});
