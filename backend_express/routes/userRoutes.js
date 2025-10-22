const express = require('express');
const router = express.Router();
const userController = require('../controllers/userControllers');
const {verifyUser} = require('../middleware/verifyUser'); // Middleware untuk verifikasi JWT

// Rute Otentikasi (Tidak Perlu Middleware)
router.post('/login', userController.loginUsers);
router.post('/register', userController.registerUser);

// Rute Terlindungi (Membutuhkan Middleware)
router.get('/',verifyUser, userController.getAllUsers); 
router.get('/:id', verifyUser, userController.getUserById); 
router.put('/:id', verifyUser, userController.updateUser);
router.delete('/:id',verifyUser, userController.deleteUser);

module.exports = router;