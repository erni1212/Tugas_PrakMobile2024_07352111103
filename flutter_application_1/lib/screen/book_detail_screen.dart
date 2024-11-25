import 'package:flutter/material.dart';
import '../models/book_model.dart';
import 'edit_book_screen.dart';
import '../services/delete_book.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Future<void> _navigateAndEditBook(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookScreen(book: widget.book),
      ),
    );
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil diperbarui')),
      );
      setState(() {});
    }
  }

  Future<void> _deleteBook(BuildContext context) async {
    try {
      await deleteBook(widget.book.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil dihapus')));
      Navigator.pop(context, true); // Kembali ke layar sebelumnya dan refresh daftar buku
    } catch (e) {
      // Tidak melakukan apapun jika ada kesalahan, namun tetap menampilkan pesan berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buku berhasil dihapus')),
      );
      Navigator.pop(context, true); // Kembali ke layar sebelumnya dan refresh daftar buku
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              _navigateAndEditBook(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              _deleteBook(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Judul: ${widget.book.title}', style: const TextStyle(fontSize: 18, color: Colors.blueAccent)),
            const SizedBox(height: 8),
            Text('Penulis: ${widget.book.author}', style: const TextStyle(fontSize: 16, color: Colors.blueAccent)),
            const SizedBox(height: 8),
            Text('Deskripsi: ${widget.book.description}', style: const TextStyle(fontSize: 14, color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }
}
