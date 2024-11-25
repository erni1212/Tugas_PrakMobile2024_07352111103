import 'package:flutter/material.dart';
import '../services/add_book.dart'; // Mengimpor fungsi addBookService dengan benar

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String author = '';
  String description = '';

  Future<void> _addBook() async {
    try {
      await addBookService(title, author, description); // Memanggil fungsi impor dengan nama yang benar
      Navigator.pop(context, true); // Menambahkan parameter 'true' agar halaman utama tahu buku baru ditambahkan
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan buku: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Buku Baru', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul', labelStyle: TextStyle(color: Colors.blueAccent)),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Penulis', labelStyle: TextStyle(color: Colors.blueAccent)),
                onChanged: (value) {
                  setState(() {
                    author = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deskripsi', labelStyle: TextStyle(color: Colors.blueAccent)),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addBook(); // Memanggil fungsi lokal yang telah diperbaiki
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Tambah Buku', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
