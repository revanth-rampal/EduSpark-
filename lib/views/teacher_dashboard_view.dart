import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../screens/attendance_screen.dart';
import 'shared/dashboard_widgets.dart'; // Import the new shared widgets file

class TeacherDashboardView extends StatelessWidget {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Your Classes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
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
                change: '2 Today',
                changeColor: Colors.grey,
                iconColor: Colors.blue,
              ),
              StatCard(
                icon: Icons.people_outline,
                label: 'Total Students',
                value: '156',
                change: '',
                changeColor: Colors.grey,
                iconColor: Colors.green,
              ),
              StatCard(
                icon: Icons.assignment_late_outlined,
                label: 'Ungraded',
                value: '12',
                change: '3 New',
                changeColor: Colors.orange,
                iconColor: Colors.orange,
              ),
              StatCard(
                icon: Icons.pending_actions_outlined,
                label: 'Pending',
                value: '5',
                change: 'Tasks',
                changeColor: Colors.grey,
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ActionCard(
            title: "Take Attendance",
            subtitle: "Start a new attendance session",
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
            onTap: () {},
          ),
        ]
            .animate(interval: 100.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
      ),
    );
  }
}
