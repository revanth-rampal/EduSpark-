import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // This function handles the navigation after the splash screen.
  _navigateToHome() async {
    // A short delay to show the branding.
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    // Using a PageRouteBuilder for a smooth fade transition to the next screen.
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Using a Stack for precise control over alignment.
        child: Stack(
          children: [
            // Align the main content to the absolute center of the screen.
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ensure the column only takes up needed space
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 120, // UPDATED: Increased logo size
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'St Joseph School',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(
                              0xFF0D47A1), // UPDATED: New color for school name
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sursum Corda',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black54, // UPDATED: New color for motto
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms),
            ),

            // Align the software provider logo to the bottom center of the screen.
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Image.asset(
                  'assets/images/EduSpark.png',
                  height: 50, // UPDATED: Increased logo size
                ),
              ).animate().fadeIn(delay: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
