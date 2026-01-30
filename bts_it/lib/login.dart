import 'package:flutter/material.dart';
import 'verification_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 230, 233),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.phone_android,
                  size: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),

            const Text(
              'Login to your Account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
            ),
            // const SizedBox(height: 15),

            // TextField(
            //   obscureText: true,
            //   decoration: const InputDecoration(
            //     labelText: 'Password',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Verification_LoginPage()));
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}