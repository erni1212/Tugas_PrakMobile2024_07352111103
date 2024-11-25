class Book {
  final String id;
  late final String title;
  late final String author;
  late final String description;

  Book({required this.id, required this.title, required this.author, required this.description});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'].toString(), // Konversi id menjadi string
      title: json['title'],
      author: json['author'],
      description: json['description'],
    );
  }
}
