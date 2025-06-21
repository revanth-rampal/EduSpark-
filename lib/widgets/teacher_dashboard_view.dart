// FILE: lib/views/teacher_dashboard_view.dart
// This file defines the UI for the Teacher's dashboard.
// It reuses the DashboardCard widget from the admin view.
// Place this file inside your 'lib/views/' folder.

import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart'; // Imports the reusable DashboardCard widget.

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // A GridView is used for a clean, card-based layout, consistent with the admin view.
    return GridView.count(
      crossAxisCount: 2, // 2 cards per row.
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        // Each card represents a key function for the teacher.
        // The "Take Attendance" card is especially important for your feature goals.
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
