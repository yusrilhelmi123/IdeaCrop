import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/ideacrop_logo.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Harvest Your Thoughts',
                style: TextStyle(color: AppTheme.primaryNeonBlue, fontSize: 16),
              ),
              const SizedBox(height: 40),
              const Text(
                'Aplikasi pengumpulan ide spontaneous yang dirancang untuk membantu inovator menangkap inspirasi kapan saja.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.mutedTextColor),
              ),
              const SizedBox(height: 48),
              const Divider(color: Colors.white10),
              const SizedBox(height: 24),
              const Text('Dikembangkan oleh:', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              const Text(
                'yusrilizer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentCyan,
                ),
              ),
              const SizedBox(height: 40),
              const Text('Versi 1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
