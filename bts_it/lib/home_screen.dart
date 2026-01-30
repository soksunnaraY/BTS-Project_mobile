import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// =======================
/// HOME SCREEN
/// =======================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Books',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QRScannerScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            BookCard(
              title: 'Business',
              books: '38 Books',
              subtitle: 'Make money make money!',
              dotColor: Colors.blue,
            ),
            BookCard(
              title: 'Network',
              books: '17 Books',
              subtitle: 'Networking made easy',
              dotColor: Colors.orange,
            ),
            BookCard(
              title: 'UI/UX Design',
              books: '3 Books',
              subtitle: 'Simple and usable interaction',
              dotColor: Colors.green,
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
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR / Barcode')),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
        ),
        onDetect: (capture) {
          if (scanned) return;

          final String? code = capture.barcodes.first.rawValue;

          if (code != null) {
            scanned = true;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BookDetailPage(qrCode: code),
              ),
            );
          }
        },
      ),
    );
  }
}

/// =======================
/// BOOK DETAIL PAGE
/// =======================
class BookDetailPage extends StatefulWidget {
  final String qrCode;

  const BookDetailPage({super.key, required this.qrCode});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final TextEditingController _inputController = TextEditingController();
  bool isAvailable = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// BOOK ICON
            Center(
              child: Column(
                children: [
                  const Icon(Icons.book, size: 80, color: Colors.blue),
                  const SizedBox(height: 10),
                  const Text(
                    'Scanned QR Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.qrCode,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const SizedBox(height: 20),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAvailable ? const Color.fromARGB(255, 189, 232, 248) : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Choose option for book'),
                        content: const Text('Do you want to mark this book as available?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isAvailable = false;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isAvailable = true;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  isAvailable ? 'Available' : 'Reading',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


/// =======================
/// BOOK CARD WIDGET
/// =======================
class BookCard extends StatelessWidget {
  final String title;
  final String books;
  final String subtitle;
  final Color dotColor;

  const BookCard({
    super.key,
    required this.title,
    required this.books,
    required this.subtitle,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: dotColor),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  books,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
            SizedBox(
            width: 110,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Choose option for "$title"'),
                      content: const Text('Do you want to mark this book as available?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('"Unavailable" selected for $title')),
                            );
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('"Available" selected for $title')),
                            );
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                'Reading',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





