import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Selamat pagi";
    } else if (hour < 15) {
      return "Selamat siang";
    } else if (hour < 18) {
      return "Selamat sore";
    } else {
      return "Selamat malam";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/ideacrop_logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),

            Text(
              "${getGreeting()} sang inovator!",
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
