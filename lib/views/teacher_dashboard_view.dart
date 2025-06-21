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
        DashboardCard(
          icon: Icons.camera_alt_rounded,
          title: 'Take Attendance',
        ),
        DashboardCard(
          icon: Icons.assignment_ind_rounded,
          title: 'View Students',
        ),
        DashboardCard(
          icon: Icons.assignment_turned_in_rounded,
          title: 'Post Assignments',
        ),
        DashboardCard(
          icon: Icons.schedule_rounded,
          title: 'My Schedule',
        ),
        DashboardCard(
          icon: Icons.assessment_rounded,
          title: 'Enter Grades',
        ),
        DashboardCard(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'Parent Communication',
        ),
      ],
    );
  }
}
