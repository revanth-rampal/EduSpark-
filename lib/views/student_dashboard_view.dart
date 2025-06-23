import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'shared/dashboard_widgets.dart'; // Import the new shared widgets file

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using the same subtle background for a consistent look.
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
            "Your Day at a Glance",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Section 2: Statistics Grid for Student
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              StatCard(
                icon: Icons.check_circle_outline_rounded,
                label: 'Attendance',
                value: '96.8%',
                iconColor: Colors.green,
              ),
              StatCard(
                icon: Icons.star_border_rounded,
                label: 'Avg. Grade',
                value: '89.5',
                iconColor: Colors.orange,
              ),
              StatCard(
                icon: Icons.assignment_turned_in_outlined,
                label: 'Assignments',
                value: '12/15',
                iconColor: Colors.blue,
              ),
              StatCard(
                icon: Icons.directions_bus_outlined,
                label: 'Bus ETA',
                value: '8 min',
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section 3: Quick Actions for Student
          const Text(
            "What's Next?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ActionCard(
            title: "View Timetable",
            subtitle: "Check your class schedule for today",
            icon: Icons.schedule_outlined,
            onTap: () {},
          ),
          ActionCard(
            title: "View Assignments",
            subtitle: "See upcoming homework and due dates",
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
