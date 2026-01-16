import 'package:bts_it/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        
        title: const Text(
          'Books',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView(
                children: const [
                  BookCard(
                    title: 'Business',
                    books: '38 Books',
                    subtitle: 'Make money make money!',
                    dotColor: Color.fromARGB(255, 56, 147, 232),
                  ),
                  BookCard(
                    title: 'Network',
                    books: '17 Books',
                    subtitle: 'Networking made easy',
                    dotColor: Color.fromARGB(255, 54, 149, 244),
                  ),
                  BookCard(
                    title: 'UI/UX Design',
                    books: '3 Books',
                    subtitle: 'Simple and Usable Interaction',
                    dotColor: Color.fromARGB(255, 0, 174, 255),
                  ),
                  BookCard(
                    title: 'development',
                    books: '7 Books',
                    subtitle: 'Flutter Development from Scratch',
                    dotColor: Color.fromARGB(255, 76, 150, 175),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


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
            blurRadius: 12,
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
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: dotColor,
                    ),
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
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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