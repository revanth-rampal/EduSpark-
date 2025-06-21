// FILE: lib/screens/dashboard_screen.dart
// This screen acts as a router, displaying the correct dashboard view (Admin, Teacher, or Student)
// based on the userRole passed from the login screen.
// Place this file inside your 'lib/screens/' folder.

import 'package:flutter/material.dart';
import 'login_screen.dart'; // To allow logging out and returning to the login page.
import '../views/admin_dashboard_view.dart'; // Imports the Admin's specific view.
import '../views/teacher_dashboard_view.dart'; // Imports the Teacher's specific view.
import '../views/student_dashboard_view.dart'; // Imports the Student's specific view.

class DashboardScreen extends StatelessWidget {
  final String userRole;

  const DashboardScreen({Key? key, required this.userRole}) : super(key: key);

  // This helper function returns the correct dashboard view widget
  // based on the user's role. Using a helper keeps the main build method clean.
  Widget _getDashboardView() {
    switch (userRole) {
      case 'Admin':
        return const AdminDashboardView();
      case 'Teacher':
        return const TeacherDashboardView();
      case 'Student':
        return const StudentDashboardView();
      default:
        // This is a fallback case. In a real app, you might want to log this
        // unexpected state or show a more detailed error message.
        return const Center(
          child: Text(
            'Error: Unknown user role.',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title of the dashboard is dynamically set based on the user's role.
        title: Text('$userRole Dashboard'),
        backgroundColor: Colors.indigo,
        elevation: 4.0, // Adds a subtle shadow below the app bar.
        actions: [
          // This IconButton provides a way for the user to log out.
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip:
                'Logout', // Shows 'Logout' when the user long-presses the icon.
            onPressed: () {
              // Navigate back to the login screen.
              // 'pushAndRemoveUntil' clears the entire navigation stack, so the
              // user cannot press the back button to return to the dashboard
              // after logging out.
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      // The body of the scaffold is set to the specific dashboard view
      // returned by our helper function.
      body: _getDashboardView(),
    );
  }
}
