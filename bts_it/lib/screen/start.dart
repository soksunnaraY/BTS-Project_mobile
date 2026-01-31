import 'package:flutter/material.dart';
import 'register.dart';


class StartPage extends StatelessWidget {
  final String userName;

  const StartPage({super.key, this.userName = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Library',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/start_page.png',
              height: 180,
            ),

            const SizedBox(height: 25),

           
            Text(
              'Welcome $userName\nto LIBRARY TRACKING SYSTEM',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 25),

          
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
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 LOGIN
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const LoginPage(),
            //       ),
            //     );
            //   },
            //   child: const Text(
            //     'Login',
            //     style: TextStyle(color: Colors.grey),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
