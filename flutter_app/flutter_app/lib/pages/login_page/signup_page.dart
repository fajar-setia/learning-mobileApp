import 'package:flutter/material.dart';
import 'package:flutter_app/feature/import_features.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// URL Endpoint Register Anda (Sesuaikan port dan IP jika perlu)
// ignore: constant_identifier_names
const String _REGISTER_ENDPOINT =
    'http://192.168.100.13:5000/api/users/register';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers untuk setiap field sesuai model backend
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final postalCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Key untuk validasi form

  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    streetController.dispose();
    cityController.dispose();
    provinceController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  // --- Fungsi untuk Mengirim Data Registrasi ke Backend ---
  Future<void> _register() async {
    if (!formKey.currentState!.validate()) {
      return; // Jangan lanjutkan jika form belum valid
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(_REGISTER_ENDPOINT),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          // Mengirim data SESUAI nama properti Mongoose Anda
          'username': usernameController.text,
          'email': emailController.text,
          'fullName': fullNameController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'address': {
            'street': streetController.text,
            'city': cityController.text,
            'province': provinceController.text,
            'postalCode': postalCodeController.text,
          },
        }),
      );

      if (mounted) {
        if (response.statusCode == 201) {
          // Pendaftaran Berhasil
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pendaftaran berhasil! Silakan Login.'),
            ),
          );
          // Navigasi kembali ke halaman login atau halaman sebelumnya
          Navigator.pop(context);
        } else {
          // Pendaftaran Gagal (misal email/username sudah terdaftar, status 400)
          final errorData = json.decode(response.body);
          final message = errorData['message'] ?? 'Pendaftaran gagal.';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koneksi gagal. Cek server Anda.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  // -------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppFeaturesImage.bg_login),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: SafeArea(
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.6),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
                  onPressed: () => Navigator.pop(context),
                  
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // --- Bagian Utama ---
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: .2),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Informasi Akun',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              radius: BorderRadius.circular(10),
                            ),
                            _buildTextField(
                              usernameController,
                              'Username',
                              (value) => value!.isEmpty
                                  ? 'Username harus diisi'
                                  : null,
                            ),
                            _buildTextField(
                              emailController,
                              'Email',
                              (value) => !value!.contains('@')
                                  ? 'Email tidak valid'
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextField(
                              passwordController,
                              'Password',
                              (value) =>
                                  value!.length < 6 ? 'Min. 6 karakter' : null,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),
                      // --- Bagian Detail Pribadi ---
                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: .2),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Detail Pribadi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              radius: BorderRadius.circular(20),
                            ),
                            _buildTextField(
                              fullNameController,
                              'Nama Lengkap',
                              (value) => value!.isEmpty
                                  ? 'Nama Lengkap harus diisi'
                                  : null,
                            ),
                            _buildTextField(
                              phoneController,
                              'Nomor Telepon',
                              (value) => value!.isEmpty
                                  ? 'Nomor telepon harus diisi'
                                  : null,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        margin: EdgeInsets.only(top: 2.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: .2),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Alamat Pengiriman',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              radius: BorderRadius.circular(20),
                            ),
                            _buildTextField(
                              streetController,
                              'Nama Jalan & Nomor Rumah',
                              (value) =>
                                  value!.isEmpty ? 'Jalan harus diisi' : null,
                            ),
                            _buildTextField(
                              cityController,
                              'Kota/Kabupaten',
                              (value) =>
                                  value!.isEmpty ? 'Kota harus diisi' : null,
                            ),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[400],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'DAFTAR SEKARANG',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pembantu untuk mempersingkat TextField
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String? Function(String?)? validator, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: .2),
        ),
      ),
    );
  }
}
