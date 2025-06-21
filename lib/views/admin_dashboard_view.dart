import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'shared/dashboard_widgets.dart'; // Import the new shared widgets file

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

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
            "Overview",
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
                icon: Icons.people_outline,
                label: 'Total Students',
                value: '1,247',
                change: '+12',
                changeColor: Colors.green,
                iconColor: Colors.blue,
              ),
              StatCard(
                icon: Icons.check_circle_outline,
                label: 'Attendance',
                value: '94.2%',
                change: '+2.1%',
                changeColor: Colors.green,
                iconColor: Colors.green,
              ),
              StatCard(
                icon: Icons.star_border,
                label: 'Avg. Grade',
                value: '87.3',
                change: '-0.5',
                changeColor: Colors.red,
                iconColor: Colors.orange,
              ),
              StatCard(
                icon: Icons.directions_bus_outlined,
                label: 'Active Buses',
                value: '12',
                change: 'On time',
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
            title: "Manage Users",
            subtitle: "Add, edit, or remove users",
            onTap: () {},
          ),
          ActionCard(
            title: "Send Notice",
            subtitle: "Broadcast a message to all users",
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
