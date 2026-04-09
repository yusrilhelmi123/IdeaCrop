import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme.dart';
import 'data/models/idea_model.dart';
import 'presentation/screens/home_screen.dart';

import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Adapter
  Hive.registerAdapter(IdeaModelAdapter());
  
  // Open Box
  await Hive.openBox<IdeaModel>('ideas');

  runApp(
    const ProviderScope(
      child: IdeaCropApp(),
    ),
  );
}

class IdeaCropApp extends StatelessWidget {
  const IdeaCropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdeaCrop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
