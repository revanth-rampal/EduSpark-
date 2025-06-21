import 'package:flutter/material.dart';
import '../views/admin_dashboard_view.dart';
import '../views/student_dashboard_view.dart';
import '../views/teacher_dashboard_view.dart';
import 'custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  final String userRole;

  const DashboardScreen({Key? key, required this.userRole}) : super(key: key);

  // This helper function returns the correct dashboard content view
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
        // A fallback in case of an unknown role.
        return const Center(child: Text('Error: Unknown user role.'));
    }
  }

  // This function sets the title in the AppBar based on the role.
  String _getAppBarTitle() {
    switch (userRole) {
      case 'Admin':
        return 'Admin Dashboard';
      case 'Teacher':
        return 'Teacher Dashboard';
      case 'Student':
        return 'Welcome, Revanth!'; // Can be personalized
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar is the equivalent of your Header.tsx.
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        // 'actions' are the widgets on the right side of the AppBar.
        actions: [
          // Notifications Icon
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
            onPressed: () {
              // Placeholder for notification logic
            },
          ),
          // User Profile Avatar
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/user-avatar.png'),
            ),
          ),
        ],
      ),
      // The Drawer is the equivalent of your Sidebar.tsx.
      drawer: CustomDrawer(userRole: userRole),
      // The body will display the specific dashboard content.
      body: _getDashboardView(),
    );
  }
}
