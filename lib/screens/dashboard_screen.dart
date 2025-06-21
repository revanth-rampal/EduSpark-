import 'package:flutter/material.dart';
import '../views/admin_dashboard_view.dart';
import '../views/student_dashboard_view.dart';
import '../views/teacher_dashboard_view.dart';
import 'custom_drawer.dart'; // We will create this file next

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

  String _getGreeting() {
    switch (userRole) {
      case 'Admin':
        return 'Admin Dashboard';
      case 'Teacher':
        return 'Teacher Dashboard';
      case 'Student':
        return 'Welcome, Revanth!'; // Placeholder name
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getGreeting()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0, left: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/user-avatar.png'), // Placeholder user avatar
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(userRole: userRole),
      body: _getDashboardView(),
    );
  }
}
