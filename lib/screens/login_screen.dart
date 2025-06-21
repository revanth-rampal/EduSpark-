// FILE: lib/screens/login_screen.dart
// This screen handles user login and role selection.
// Place this file inside your 'lib/screens/' folder.

import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Imports the next screen in the same folder.

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A list of roles for the dropdown menu.
  final List<String> _roles = ['Student', 'Teacher', 'Admin'];
  String? _selectedRole;

  // Global key to identify the form and enable validation.
  final _formKey = GlobalKey<FormState>();

  // Controllers to manage the text in the input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set 'Student' as the default selected role when the screen loads.
    _selectedRole = _roles[0];
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed from the widget tree
    // to free up resources.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Check if all form fields have passed their validation rules.
    if (_formKey.currentState!.validate()) {
      // If validation is successful, proceed with login.
      // In a real application, you would add authentication logic here
      // (e.g., call an API, check credentials with Firebase).

      // For this demo, we navigate directly to the dashboard screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // Pass the selected role to the dashboard so it knows what to display.
          builder: (context) => DashboardScreen(userRole: _selectedRole!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          // Using SingleChildScrollView prevents the UI from overflowing
          // when the keyboard appears on smaller screens.
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Client Logo
                  Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 16),

                  // Welcome Text
                  const Text(
                    'Welcome to EduSpark',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please sign in to continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),

                  // Role Selector Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'I am a...',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    items: _roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Input Field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Use a regular expression for basic email format validation.
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null; // Return null if the input is valid.
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Input Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText:
                        true, // Hides the password text as the user types.
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null; // Return null if the input is valid.
                    },
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
