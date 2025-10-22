const User = require('../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');


dotenv.config();

// Ambil Secret Key dan Expiry dari Environment Variables
const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '1d'; 

// -----------------------------------------------------------------

exports.registerUser = async (req, res) => {
    const {username, email, fullName, phone, password, address} = req.body;

    try{
        console.log(`[DEBUG] Login attempt for username: ${username}`);
        console.log(`[DEBUG] Password received (plaintext): ${password}`);
        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({message: "Email sudah terdaftar."});
        }
        
        const salt = await bcrypt.genSalt(10);
        const hashPass = await bcrypt.hash(password, salt);

        // PERBAIKAN: Gunakan 'User' (huruf besar)
        const newUser = new User({
            username,
            email,
            fullName,
            phone,
            password: hashPass,
            address
        });

        const savedUser = await newUser.save();

        const userResponse = savedUser.toObject();
        delete userResponse.password;

        res.status(201).json({
            message: "Pendaftaran berhasil",
            user: userResponse,
        });
        
    }catch(error){
        console.error("Register Error:", error);
        res.status(500).json({message: "Pendaftaran gagal", error: error.message});
    }
};

// -----------------------------------------------------------------

exports.loginUsers = async (req,res) => {
    try{
        const {username, password} = req.body;

        const userLog = await User.findOne({username});

        // PERBAIKAN LOGIKA 1: Cek userLog DULU sebelum mengakses properti
        if (!userLog) {
            return res.status(401).json({message: "Username atau password salah"});
        }
        
        // PERBAIKAN LOGIKA 2: Bandingkan password setelah dipastikan userLog ada
        const validPassword = await bcrypt.compare(password, userLog.password);

        if(!validPassword) {
            return res.status(401).json({message: "Username atau password salah"});
        }

        const payload = {
            id: userLog._id,
            role: userLog.role 
        };

        // Buat Token
        const token = jwt.sign(
            payload, 
            JWT_SECRET, // Sudah didefinisikan di awal file
            { expiresIn: JWT_EXPIRES_IN } // Sudah didefinisikan di awal file
        );

        // PERBAIKAN: Ganti status 201 menjadi 200 OK
        res.status(200).json({
            message: "Login Berhasil",
            token: token,
            user: { id: userLog._id, username: userLog.username, role: userLog.role }
        });

    }catch(error){
        console.error("Login Error:", error);
        // PERBAIKAN: Ganti status 201 menjadi 500 Internal Server Error
        res.status(500).json({message: "Gagal login. Terjadi kesalahan server."});
    }

    
};

exports.getAllUsers = async (req, res) => {
    // Placeholder - Logic untuk mengambil semua user
    res.status(200).json({ message: "Endpoint getAllUsers works!" });
};

exports.getUserById = async (req, res) => {
    // Placeholder - Logic untuk mengambil user berdasarkan ID
    res.status(200).json({ message: "Endpoint getUserById works!" });
};

exports.updateUser = async (req, res) => {
    // Placeholder - Logic untuk memperbarui user
    res.status(200).json({ message: "Endpoint updateUser works!" });
};

exports.deleteUser = async (req, res) => {
    // Placeholder - Logic untuk menghapus user
    res.status(200).json({ message: "Endpoint deleteUser works!" });
};