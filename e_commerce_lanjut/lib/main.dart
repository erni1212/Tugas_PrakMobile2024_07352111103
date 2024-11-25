import 'package:e_commerce_lanjut/screens/checkout_screen.dart';
import 'package:e_commerce_lanjut/screens/home_screen.dart';
import 'package:e_commerce_lanjut/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
