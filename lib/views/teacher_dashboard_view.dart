import 'package:flutter/material.dart';
import '../screens/attendance_screen.dart'; // We will create this new screen next
import 'admin_dashboard_view.dart'; // Reusing the StatCard

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Welcome Section
        const Text(
          'Hello, Teacher!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Let's have a look at your classes today.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),

        // 2. Stats Grid for Teacher
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            StatCard(
              icon: Icons.people_outline,
              label: 'My Students',
              value: '156',
              change: '+3',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.check_circle_outline,
              label: 'Present Today',
              value: '142',
              change: '91%',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.warning_amber_outlined,
              label: 'Absent Today',
              value: '14',
              change: '-2',
              changeColor: Colors.red,
            ),
            StatCard(
              icon: Icons.trending_up,
              label: 'Class Average',
              value: '85.7',
              change: '+2.3',
              changeColor: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // 3. Quick Actions Section - NEW
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          context: context,
          icon: Icons.camera_alt_outlined,
          title: 'Take Attendance',
          subtitle: 'Mark attendance for your classes',
          onTap: () {
            // This is where the navigation happens
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AttendanceScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionCard(
          context: context,
          icon: Icons.assignment_outlined,
          title: 'Post Assignment',
          subtitle: 'Create and assign new homework',
          onTap: () {},
        ),
      ],
    );
  }

  // Helper widget for the new action cards
  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.indigo, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
