import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> updateBook(String id, String title, String author, String description) async {
  final response = await http.put(
    Uri.parse('https://events.hmti.unkhair.ac.id/api/books/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'author': author,
      'description': description,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal memperbarui buku: ${response.body}');
  }
}
