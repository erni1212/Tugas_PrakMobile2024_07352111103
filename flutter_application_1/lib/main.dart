import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/book_list_screen.dart';
import 'screen/book_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blueAccent,
      ),
      home: const BookListScreen(),
    );
  }
}
