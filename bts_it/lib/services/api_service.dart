import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../model/book.dart';

class Location {
  final String id;
  final String name;
  final String description;
  final String type;

  Location({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
    );
  }
}


class ApiService {
  final String baseUrl = 'http://192.168.88.189:3000';
  String? token;


String extractBookIdFromJwt(String jwt) {
  final parts = jwt.split('.');

  if (parts.length != 3) {
    throw Exception("Invalid JWT");
  }

  final payload = parts[1];

  final normalized = base64Url.normalize(payload);
  final decoded = utf8.decode(base64Url.decode(normalized));

  final data = jsonDecode(decoded);

  if (!data.containsKey('sub')) {
    throw Exception("No sub in token");
  }

  return data['sub'];
}

  // LOGIN
  // LOGIN
  Future<void> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Login response status: ${res.statusCode}');

    if (res.statusCode == 201 || res.statusCode == 200) {
      final data = jsonDecode(res.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await prefs.setString('token', data['token']);
      token = data['token'];
    } else {
      throw Exception("Login failed");
    }
  }

  // GET ALL BOOKS
  Future<List<Book>> getAllBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("No token found. Please login again.");
    }

    final res = await http.get(
      Uri.parse('$baseUrl/books'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);

      return data.map((e) => Book.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load books: ${res.statusCode}");
    }
  }


  // FETCH BOOK FROM QR
Future<Book> fetchBook(String qrRaw) async {
  if (token == null) throw Exception('Unauthorized: Login first');

  String? qrToken;

  // Try URL
  final uri = Uri.tryParse(qrRaw);

  if (uri != null && uri.queryParameters.containsKey('token')) {
    qrToken = uri.queryParameters['token'];
  }

  // Raw JWT
  qrToken ??= qrRaw;

  if (qrToken.isEmpty) {
    throw Exception("Invalid QR");
  }

  // 🔥 Decode JWT to get bookId
  final bookId = extractBookIdFromJwt(qrToken);

  debugPrint("BOOK ID FROM JWT: $bookId");

  final url = Uri.parse('$baseUrl/books/$bookId');

  debugPrint("FINAL API URL: $url");

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  debugPrint("STATUS: ${response.statusCode}");
  debugPrint("BODY: ${response.body}");

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    return Book.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(
      'Failed (${response.statusCode}): ${response.body}',
    );
  }
}
  Future<void> updateBookStatus(String bookId, String status) async {
  if (token == null) throw Exception("Unauthorized");

  final url = Uri.parse('$baseUrl/books/$bookId/status');

  final res = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'newStatus': status,
    }),
  );

  debugPrint("UPDATE STATUS: ${res.statusCode}");
  debugPrint("BODY: ${res.body}");

  if (res.statusCode != 200) {
    throw Exception("Failed to update status");
  }
}
}