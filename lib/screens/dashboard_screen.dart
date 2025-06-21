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
