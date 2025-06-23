import 'package:flutter/material.dart';
import '../views/admin_dashboard_view.dart';
import '../views/student_dashboard_view.dart';
import '../views/teacher_dashboard_view.dart';
import 'custom_drawer.dart';
import 'user_profile_screen.dart'; // Import the new profile screen

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
      case 'Parent': // Parent and Student can share a similar view for now
        return const StudentDashboardView();
      default:
        return const Center(child: Text('Error: Unknown user role.'));
    }
  }

  String _getAppBarTitle() {
    switch (userRole) {
      case 'Admin':
        return 'Admin Dashboard';
      case 'Teacher':
        return 'Teacher Dashboard';
      case 'Student':
      case 'Parent':
        return 'Welcome!';
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 8.0),
            child: GestureDetector(
              onTap: () {
                // FIXED: Removed the 'userRole' parameter, as it's not needed by UserProfileScreen.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/user-avatar.png'),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(userRole: userRole),
      body: _getDashboardView(),
    );
  }
}
