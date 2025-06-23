import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../screens/attendance_screen.dart';
import 'shared/dashboard_widgets.dart'; // Import the new shared widgets file

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using the same subtle background for consistency.
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Title
          const Text(
            "Your Classes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Section 2: Statistics Grid for Teacher
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              StatCard(
                icon: Icons.class_outlined,
                label: 'Total Classes',
                value: '4',
                iconColor: Colors.blue,
              ),
              StatCard(
                icon: Icons.people_outline_rounded,
                label: 'Total Students',
                value: '156',
                iconColor: Colors.green,
              ),
              StatCard(
                icon: Icons.assignment_late_outlined,
                label: 'Ungraded',
                value: '12',
                iconColor: Colors.orange,
              ),
              StatCard(
                icon: Icons.pending_actions_outlined,
                label: 'Pending',
                value: '5',
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section 3: Quick Actions for Teacher
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ActionCard(
            title: "Take Attendance",
            subtitle: "Start a new attendance session",
            icon: Icons.camera_alt_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AttendanceScreen()),
              );
            },
          ),
          ActionCard(
            title: "Post Assignment",
            subtitle: "Create and distribute homework",
            icon: Icons.assignment_outlined,
            onTap: () {},
          ),
        ]
            // Animate all widgets in the list for a smooth entrance.
            .animate(interval: 100.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
      ),
    );
  }
}
