// lib/main.dart

import 'package:flutter/material.dart';
// THIS IS THE CORRECT LINE
import 'screens/badges_page.dart'; // Import the main screen // Import the main screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Achievements',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // slate-50
        fontFamily:
            'Inter', // Optional: for a nicer font, add google_fonts package
      ),
      debugShowCheckedModeBanner: false,
      home: const BadgesUIPage(), // Set the home page
    );
  }
}
