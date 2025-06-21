// Place this code in: lib/main.dart

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const EduSparkApp());
}

class EduSparkApp extends StatelessWidget {
  const EduSparkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduSpark',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16.0),
            labelLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.indigo[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: Colors.indigo[700]!),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          // CORRECTED: Used CardThemeData instead of CardTheme
          cardTheme: CardThemeData(
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(8),
          )),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
```
```dart
// Place this code in: lib/screens/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/EduSpark_Logo.jpg', height: 120),
                    const SizedBox(height: 24),
                    Text('EduSpark', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.indigo[800], fontSize: 32)),
                    const SizedBox(height: 16),
                    Text('Enlightening Futures', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.indigo[600], fontSize: 18)),
                  ],
                ),
              ),
              const Spacer(),
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
```
```dart
// Place this code in: lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _roles = ['Student', 'Teacher', 'Admin'];
  String? _selectedRole;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles[0];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/logo.png', height: 80),
                  const SizedBox(height: 16),
                  const Text('Welcome to EduSpark', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                  const SizedBox(height: 8),
                  const Text('Please sign in to continue', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 40),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: const InputDecoration(labelText: 'I am a...', prefixIcon: Icon(Icons.person_outline_rounded)),
                    items: _roles.map((String role) => DropdownMenuItem<String>(value: role, child: Text(role))).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email address';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your password';
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
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
```
```dart
// Place this code in: lib/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../views/admin_dashboard_view.dart';
import '../views/teacher_dashboard_view.dart';
import '../views/student_dashboard_view.dart';

class DashboardScreen extends StatelessWidget {
  final String userRole;

  const DashboardScreen({Key? key, required this.userRole}) : super(key: key);

  Widget _getDashboardView() {
    switch (userRole) {
      case 'Admin':
        return const AdminDashboardView();
      case 'Teacher':
        return const TeacherDashboardView();
      case 'Student':
        return const StudentDashboardView();
      default:
        return const Center(child: Text('Error: Unknown user role.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$userRole Dashboard'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: _getDashboardView(),
    );
  }
}
```
```dart
// Place this code in: lib/views/admin_dashboard_view.dart

import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        DashboardCard(icon: Icons.manage_accounts_rounded, title: 'Manage Teachers'),
        DashboardCard(icon: Icons.people_alt_rounded, title: 'Manage Students'),
        DashboardCard(icon: Icons.bar_chart_rounded, title: 'View Reports'),
        DashboardCard(icon: Icons.notifications_active_rounded, title: 'Send Alerts'),
        DashboardCard(icon: Icons.class_rounded, title: 'Manage Classes'),
        DashboardCard(icon: Icons.settings_rounded, title: 'System Settings'),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key? key, required this.icon, required this.title}) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title feature coming soon!'),
              backgroundColor: Colors.indigo,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
```
```dart
// Place this code in: lib/views/teacher_dashboard_view.dart

import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart';

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        DashboardCard(icon: Icons.camera_alt_rounded, title: 'Take Attendance'),
        DashboardCard(icon: Icons.assignment_ind_rounded, title: 'View Students'),
        DashboardCard(icon: Icons.assignment_turned_in_rounded, title: 'Post Assignments'),
        DashboardCard(icon: Icons.schedule_rounded, title: 'My Schedule'),
        DashboardCard(icon: Icons.assessment_rounded, title: 'Enter Grades'),
        DashboardCard(icon: Icons.chat_bubble_outline_rounded, title: 'Parent Communication'),
      ],
    );
  }
}
```
```dart
// Place this code in: lib/views/student_dashboard_view.dart

import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart';

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        DashboardCard(icon: Icons.check_circle_outline_rounded, title: 'View Attendance'),
        DashboardCard(icon: Icons.assignment_late_rounded, title: 'View Assignments'),
        DashboardCard(icon: Icons.schedule_rounded, title: 'My Schedule'),
        DashboardCard(icon: Icons.grade_rounded, title: 'My Grades'),
        DashboardCard(icon: Icons.menu_book_rounded, title: 'Course Materials'),
        DashboardCard(icon: Icons.event_available_rounded, title: 'School Events'),
      ],
    );
  }
}
