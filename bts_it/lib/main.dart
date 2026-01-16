import 'package:flutter/material.dart';
import 'start.dart'; // 👈 MUST MATCH FILE NAME


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(), // 👈 MUST MATCH CLASS NAME
    );
  }
}
