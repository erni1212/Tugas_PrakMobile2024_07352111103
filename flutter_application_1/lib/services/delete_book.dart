import 'package:http/http.dart' as http;

Future<void> deleteBook(String id) async {
  final url = 'https://events.hmti.unkhair.ac.id/api/books/$id';
  final response = await http.delete(
    Uri.parse(url),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal menghapus buku: ${response.body}');
  }
}
