import 'dart:async';
import 'package:bts_it/home_screen.dart';
import 'package:flutter/material.dart';

class Sucessfully_loginPage extends StatefulWidget {
  const Sucessfully_loginPage({super.key});

  @override
  State<Sucessfully_loginPage> createState() => _Sucessfully_loginPageState();
}
class _Sucessfully_loginPageState extends State<Sucessfully_loginPage> {
  
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Successfully',
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
            const SizedBox(height: 15),
            const Text(
              'Welcome to\nLibrary Tracking System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Redirecting to Home...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
