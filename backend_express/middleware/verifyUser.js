const jwt = require('jsonwebtoken');
// Jika Anda menggunakan CommonJS (require), ganti menjadi: const jwt = require('jsonwebtoken');

// Pastikan JWT_SECRET diimpor dari file .env melalui process.env
const JWT_SECRET = process.env.JWT_SECRET; 

// Fungsi Middleware untuk memverifikasi token
const verifyUser = (req, res, next) => {
    // 1. Ambil token dari Header Authorization
    // Token biasanya dikirim dalam format: "Bearer <token_jwt>"
    const authHeader = req.headers.authorization;
    
    // Cek apakah header ada
    if (!authHeader) {
        return res.status(401).json({ 
            message: 'Akses ditolak. Tidak ada token otentikasi.' 
        });
    }

    // Pisahkan 'Bearer' dari token
    const token = authHeader.split(' ')[1]; 
    
    // Cek apakah token ada setelah 'Bearer'
    if (!token) {
         return res.status(401).json({ 
            message: 'Akses ditolak. Format token tidak valid.' 
        });
    }

    try {
        // 2. Verifikasi Token
        const decoded = jwt.verify(token, JWT_SECRET);

        // 3. Masukkan data user yang didecode ke objek request
        // Data ini (id dan role) bisa digunakan di controller selanjutnya
        req.user = decoded; 
        
        // Lanjutkan ke fungsi controller berikutnya
        next(); 

    } catch (error) {
        // Jika token tidak valid (expired, signature salah, dll.)
        return res.status(403).json({ 
            message: 'Token tidak valid atau kedaluwarsa.' 
        });
    }
};

// Jika Anda menggunakan CommonJS (require):
module.exports =  {verifyUser} ;