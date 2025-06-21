import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  // Ensures that the Flutter engine is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EduSparkApp());
}

class EduSparkApp extends StatelessWidget {
  const EduSparkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define a professional color palette and theme.
    const primaryColor = Color(0xFF4F46E5); // A modern, friendly blue/indigo
    const backgroundColor = Color(0xFFF9FAFB); // A very light grey for backgrounds

    // Use Google Fonts for a clean, professional typography.
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'EduSpark',
      theme: ThemeData(
        // Core theme properties
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: textTheme,

        // Consistent styling for AppBars (Headers)
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5, // Subtle shadow
          iconTheme: const IconThemeData(color: Colors.black87),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),

        // Modern styling for all text input fields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          prefixIconColor: Colors.grey.shade500,
        ),

        // Consistent styling for all primary buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            elevation: 2,
            shadowColor: primaryColor.withOpacity(0.2),
          ),
        ),
        
        // Consistent styling for all cards
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
