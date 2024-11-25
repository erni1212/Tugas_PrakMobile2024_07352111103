import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> addBookService(String title, String author, String description) async {
  final response = await http.post(
    Uri.parse('https://events.hmti.unkhair.ac.id/api/books'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'author': author,
      'description': description,
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Gagal menambahkan buku');
  }
}
