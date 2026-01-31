import 'package:flutter/foundation.dart';

class Location {
  final String name;

  Location({required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
    );
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  final String status;
  final Location location;
  final String itemNumber;
  final String isbn;
  final bool availability;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    required this.location,
    required this.itemNumber,
    required this.isbn,
    required this.availability,

  });

  factory Book.fromJson(Map<String, dynamic> json) {
  debugPrint('Parsing book: $json');

  return Book(
    id: json['id']?.toString() ?? '',
    title: json['title']?.toString() ?? '',
    author: json['author']?.toString() ?? '',

    // ✅ correct key
    itemNumber: json['itemNumber']?.toString() ?? '',

    status: json['status']?.toString() ?? '',

    // ✅ convert int → String
    isbn: json['isbn']?.toString() ?? '',

    availability: json['availability'] == true,

    location: json['location'] != null
        ? Location.fromJson(json['location'])
        : Location(name: ''),
  );
}
}