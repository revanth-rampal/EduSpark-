import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart'; // Reusing the StatCard from the admin view

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Welcome Section
        const Text(
          'Welcome, Revanth!', // Using a placeholder name
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Ready for a great day of learning?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),

        // 2. Stats Grid for Student
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            StatCard(
              icon: Icons.check_circle_outline,
              label: 'My Attendance',
              value: '96.8%',
              change: '+1.2%',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.trending_up,
              label: 'My Average',
              value: '89.5',
              change: '+3.2',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.directions_bus_outlined,
              label: 'Bus Arrival',
              value: '8 min',
              change: 'On Time',
              changeColor: Colors.grey,
            ),
            StatCard(
              icon: Icons.assignment_turned_in_outlined,
              label: 'Assignments',
              value: '12/15',
              change: '80%',
              changeColor: Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // We can add "Upcoming Classes" or "Recent Grades" sections here later
      ],
    );
  }
}
