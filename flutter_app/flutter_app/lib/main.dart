import 'package:flutter/material.dart';
import 'package:flutter_app/pages/cart_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_page/signup_page.dart';
import 'package:flutter_app/pages/product_page.dart';
import 'package:flutter_app/pages/profile_page.dart';
import 'components/bottom_nav.dart';
import 'package:flutter_app/pages/login_page/login_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FloatingBottomNav(),
      routes: {
        '/home': (context) => HomePage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(),
        '/profile':(context) => ProfilePage(),
        '/login':(context) => LoginPage(),
        '/signup':(context) => SignupPage(),
      },
    );
  }

}