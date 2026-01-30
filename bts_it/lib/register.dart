import 'package:bts_it/verification.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Register',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              /// IMAGE (Responsive height)
              Image.asset(
                'assets/images/book.jpg',
                height: size.height * 0.22, // responsive
              ),

              const SizedBox(height: 10),

              const Text(
                'Register Administration Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              /// USERNAME
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              /// PHONE
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              /// PASSWORD
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VerificationPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
