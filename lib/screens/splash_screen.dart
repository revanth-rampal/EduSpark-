// FILE: lib/screens/splash_screen.dart
// This screen provides an animated fade-in effect upon app launch.
// Place this file inside your 'lib/screens/' folder.

import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Imports the next screen in the same folder.

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Use 'with SingleTickerProviderStateMixin' to enable animation controllers.
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the controller for a 2-second animation duration.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Create the fade animation, making it ease in smoothly.
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // Start the animation as soon as the screen loads.
    _animationController.forward();

    // Set a timer to navigate to the login screen after 4 seconds.
    // This gives time for the animation to play and the user to see the branding.
    Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
      ),
    );
  }
  
  @override
  void dispose() {
    // It's important to dispose of the controller to free up resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        // The FadeTransition widget applies the animation to its child.
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              const Spacer(), // Pushes the content to the vertical center.
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Image.asset('assets/images/EduSpark_Logo.jpg', height: 120),
                    const SizedBox(height: 24),

                    // App Name
                    Text(
                      'EduSpark', 
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.indigo[800], 
                        fontSize: 32
                      )
                    ),
                    const SizedBox(height: 16),
                    
                    // App Tagline
                    Text(
                      'Enlightening Futures', 
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.indigo[600], 
                        fontSize: 18
                      )
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes the bottom logo down.
              
              // Bottom rectangular logo
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset('assets/images/EduSpark.png', height: 60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
