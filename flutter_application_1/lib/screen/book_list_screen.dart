import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/fetch_book.dart';
import 'book_detail_screen.dart';
import 'add_book_screen.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = fetchBooks();
  }

  Future<void> _refreshBooks() async {
    setState(() {
      booksFuture = fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Buku', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Book>>(
        future: booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada buku tersedia'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return Card(
                  color: Colors.lightBlue[50],
                  child: ListTile(
                    title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(book.author),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      ).then((result) {
                        if (result is Book) {
                          _refreshBooks();
                        }
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
          if (result == true) {
            _refreshBooks();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
