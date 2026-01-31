import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/book.dart';

/// =======================
/// MAIN APP
/// =======================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

/// =======================
/// HOME SCREEN
/// =======================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  List<Book> books = [];
  bool loading = true;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
  if (!mounted) return;

  setState(() {
    loading = true;
  });

  try {
    prefs = await SharedPreferences.getInstance();

    String? storedToken = prefs.getString('token');
    if (storedToken != null) {
      api.token = storedToken;
    }

    final fetchedBooks = await api.getAllBooks();

    if (!mounted) return;

    setState(() {
      books = fetchedBooks;
      loading = false;
    });
  } catch (e) {
    if (!mounted) return;

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching books: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => QRScannerScreen(api: api)),
              );
            },
          )
        ],
      ),
      body: loading
    ? const Center(child: CircularProgressIndicator())
    : RefreshIndicator(
        onRefresh: loadBooks, // 👈 connect refresh
        child: books.isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("No books found")),
                ],
              )
            : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  return BookCard(book: book, api: api);
                },
              ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final ApiService api;
  const BookCard({super.key, required this.book, required this.api});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('Author: ${book.author} | Item No: ${book.itemNumber}'),
        trailing: CircleAvatar(
          backgroundColor: book.availability ? Colors.green : Colors.red,
          radius: 8,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookDetailScreen(book: book, api: api)),
          );
        },
      ),
    );
  }
}

/// =======================
/// BOOK DETAIL SCREEN
/// =======================
class BookDetailScreen extends StatefulWidget {
  final Book book;
  final ApiService api;
  const BookDetailScreen({super.key, required this.book, required this.api});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  late bool isAvailable;
  late bool isLoading;
  

  @override
  void initState() {
    super.initState();
    isAvailable = widget.book.status == 'available';
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(widget.book.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Author: ${widget.book.author}'),
            Text('ISBN: ${widget.book.isbn}'),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: isLoading
      ? null
      : () async {
          try {
            setState(() => isLoading = true);

            // Toggle status
            final newStatus =
                isAvailable ? "reading" : "available";

            // Call backend
            await widget.api.updateBookStatus(
              widget.book.id,
              newStatus,
            );

            // Update UI
            setState(() {
              isAvailable = !isAvailable;
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Status updated")),
            );
          } catch (e) {
            setState(() => isLoading = false);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Update failed: $e")),
            );
          }
        },
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(isAvailable ? 'Available' : 'Reading'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isAvailable ? Colors.green : Colors.blue,
          ),
        ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// QR SCANNER SCREEN
/// =======================
class QRScannerScreen extends StatefulWidget {
  final ApiService api;
  const QRScannerScreen({super.key, required this.api});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool scanned = false;
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) async {
  if (scanned) return;

  final code = capture.barcodes.first.rawValue;
  if (code == null) return;

  debugPrint("RAW QR >>> $code <<<");

  setState(() => scanned = true);

  try {
    String? token;

    // Try URL format
    final uri = Uri.tryParse(code);

    if (uri != null && uri.queryParameters.containsKey('token')) {
      token = uri.queryParameters['token'];
    }

    // Try plain format: token=xxx
    if (token == null && code.contains("token=")) {
      token = code.split("token=").last;
    }

    // Try raw token
    if (token == null) {
      token = code; // assume QR = token only
    }

    if (token.isEmpty) {
      throw Exception("Invalid QR");
    }

    debugPrint("FINAL TOKEN >>> $token <<<");

    final book = await widget.api.fetchBook(token);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailScreen(book: book, api: widget.api),
      ),
    );
  } catch (e) {
    setState(() => scanned = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scan failed: $e')),
    );
  }
}
      ),
    );
  }
}
