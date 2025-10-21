import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
  final prefs = await SharedPreferences.getInstance();

  // Simulasi login sederhana
  if (usernameController.text == 'admin' && passwordController.text == '123') {
    await prefs.setString('token', 'dummy_token');

    // tampilkan snackbar SEBELUM pop
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login berhasil!')),
    );

    // beri sedikit jeda agar snackbar sempat muncul
    await Future.delayed(const Duration(milliseconds: 500));

    // lalu kembali ke halaman sebelumnya
    if (mounted) {
      Navigator.pop(context);
    }
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login gagal, periksa username/password')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
