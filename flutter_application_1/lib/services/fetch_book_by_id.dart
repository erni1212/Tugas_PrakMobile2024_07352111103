import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book_model.dart';

Future<Book> fetchBookById(String id) async {
  final response = await http.get(Uri.parse('https://events.hmti.unkhair.ac.id/api/books/$id'));

  if (response.statusCode == 200) {
    return Book.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Buku tidak ditemukan');
  }
}
