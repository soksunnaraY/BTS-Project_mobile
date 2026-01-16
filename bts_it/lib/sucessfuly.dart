import 'package:flutter/material.dart';

class SucessfulyPage extends StatelessWidget {
  const SucessfulyPage({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Successfuly',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Image.asset(
              'assets/images/book.jpg',
              height: 180,
            ),
            const Text(
              'Welcome to\n Library Tracking System',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }
}