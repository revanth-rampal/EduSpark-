import 'package:flutter/material.dart';
import '../views/admin_dashboard_view.dart';
import '../views/student_dashboard_view.dart';
import '../views/teacher_dashboard_view.dart';
import 'custom_drawer.dart'; // We will create this file next

class DashboardScreen extends StatelessWidget {
  final String userRole;

  const DashboardScreen({Key? key, required this.userRole}) : super(key: key);

  // This helper function returns the correct dashboard view widget
  // based on the user's role.
  Widget _getDashboardView() {
    switch (userRole) {
      case 'Admin':
        return const AdminDashboardView();
      case 'Teacher':
        return const TeacherDashboardView();
      case 'Student':
        return const StudentDashboardView();
      default:
        return const Center(
          child: Text('Error: Unknown user role.'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar is our "Header" component
      appBar: AppBar(
        title: Text('$userRole Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        // The "actions" are the widgets on the right side of the AppBar
        actions: [
          // This will be our "Notifications" icon
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Placeholder for showing notifications
            },
          ),
          const SizedBox(width: 10),
          // This will be our "UserProfile" icon
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=100'),
            ),
          ),
        ],
      ),
      // The Drawer is our "Sidebar" component
      drawer: CustomDrawer(userRole: userRole),
      // The body of the scaffold will hold the main content for each role's dashboard
      body: _getDashboardView(),
      backgroundColor: Colors.grey[100],
    );
  }
}
