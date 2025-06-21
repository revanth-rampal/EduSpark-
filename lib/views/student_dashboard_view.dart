import 'package:flutter/material.dart';
import 'admin_dashboard_view.dart'; // To reuse _StatCard and _ActionCard

class StudentDashboardView extends StatelessWidget {
  const StudentDashboardView({Key? key}) : super(key: key);

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
            "Your Day at a Glance",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Statistics Grid for the Student
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatCard(
                icon: Icons.check_circle_outline,
                label: 'Attendance',
                value: '96.8%',
                change: '+1.2%',
                changeColor: Colors.green,
                iconColor: Colors.green,
              ),
              _StatCard(
                icon: Icons.star_border,
                label: 'Avg. Grade',
                value: '89.5',
                change: '+3.2',
                changeColor: Colors.green,
                iconColor: Colors.orange,
              ),
              _StatCard(
                icon: Icons.assignment_turned_in_outlined,
                label: 'Assignments',
                value: '12/15',
                change: '3 Due',
                changeColor: Colors.orange,
                iconColor: Colors.blue,
              ),
              _StatCard(
                icon: Icons.directions_bus_outlined,
                label: 'Bus ETA',
                value: '8 min',
                change: 'On Time',
                changeColor: Colors.grey,
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Quick Actions Section for the Student
          const Text(
            "What's Next?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _ActionCard(
            title: "View Timetable",
            subtitle: "Check your class schedule for today",
            icon: Icons.schedule_outlined,
            onTap: () {},
          ),
          _ActionCard(
            title: "View Assignments",
            subtitle: "See upcoming homework and due dates",
            icon: Icons.assignment_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
