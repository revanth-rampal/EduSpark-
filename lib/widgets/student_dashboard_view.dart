// FILE: lib/views/student_dashboard_view.dart
// This file defines the UI for the Student's dashboard.
// It also reuses the DashboardCard widget for a consistent UI.
// Place this file inside your 'lib/views/' folder.

import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart'; // Imports the reusable DashboardCard widget.

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using GridView for a consistent card-based layout.
    return GridView.count(
      crossAxisCount: 2, // Two cards per row.
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        // Each DashboardCard represents a feature available to the student.
        DashboardCard(
          icon: Icons.check_circle_outline_rounded,
          title: 'View Attendance',
        ),
        DashboardCard(
          icon: Icons.assignment_late_rounded,
          title: 'View Assignments',
        ),
        DashboardCard(
          icon: Icons.schedule_rounded,
          title: 'My Schedule',
        ),
        DashboardCard(
          icon: Icons.grade_rounded,
          title: 'My Grades',
        ),
        DashboardCard(
          icon: Icons.menu_book_rounded,
          title: 'Course Materials',
        ),
        DashboardCard(
          icon: Icons.event_available_rounded,
          title: 'School Events',
        ),
      ],
    );
  }
}
