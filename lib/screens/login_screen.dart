import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _roles = ['Student', 'Teacher', 'Admin'];
  String _selectedRole = 'Student';
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DashboardScreen(userRole: _selectedRole),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar icons to dark for better contrast on a light background
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Container(
        // UPDATED: Using a white-to-purple gradient for a light theme.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              primaryColor.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- Header ---
                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: primaryColor, // Use primary color for the title
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- Clean Form Container ---
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("I am a..."),
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              decoration: _buildInputDecoration(),
                              items: _roles
                                  .map((role) => DropdownMenuItem(
                                      value: role, child: Text(role)))
                                  .toList(),
                              onChanged: (newValue) {
                                if (newValue != null)
                                  setState(() => _selectedRole = newValue);
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildLabel("Email Address"),
                            TextFormField(
                              decoration: _buildInputDecoration(
                                  hint: 'you@example.com'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => (v == null ||
                                      !RegExp(r'\S+@\S+\.\S+').hasMatch(v))
                                  ? 'Please enter a valid email'
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            _buildLabel("Password"),
                            TextFormField(
                              obscureText: _obscureText,
                              decoration: _buildInputDecoration(
                                      hint: 'Enter your password')
                                  .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.grey.shade500),
                                  onPressed: () => setState(
                                      () => _obscureText = !_obscureText),
                                ),
                              ),
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'Please enter your password'
                                  : null,
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _login,
                                child: const Text('SIGN IN'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: TextStyle(color: Colors.grey.shade600)),
                        Text('Sign up',
                            style: GoogleFonts.inter(
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for consistent label styling in a light theme
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper method for consistent input field styling in a light theme
  InputDecoration _buildInputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2)),
    );
  }
}
