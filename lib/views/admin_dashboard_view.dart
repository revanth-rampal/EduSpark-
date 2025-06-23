import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'shared/dashboard_widgets.dart'; // Import the new shared widgets file

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using a subtle background for a professional texture.
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section 1: Overview Title
          const Text(
            "Overview",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Section 2: Statistics Grid using the shared StatCard
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              StatCard(
                icon: Icons.people_outline_rounded,
                label: 'Total Students',
                value: '1,247',
                iconColor: Colors.blue,
              ),
              StatCard(
                icon: Icons.check_circle_outline_rounded,
                label: 'Attendance',
                value: '94.2%',
                iconColor: Colors.green,
              ),
              StatCard(
                icon: Icons.star_border_rounded,
                label: 'Avg. Grade',
                value: '87.3',
                iconColor: Colors.orange,
              ),
              StatCard(
                icon: Icons.directions_bus_outlined,
                label: 'Active Buses',
                value: '12',
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Section 3: Quick Actions using the shared ActionCard
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ActionCard(
            title: "Manage Users",
            subtitle: "Add, edit, or remove users",
            icon: Icons.people_alt_outlined,
            onTap: () {},
          ),
          ActionCard(
            title: "Send Notice",
            subtitle: "Broadcast a message to all users",
            icon: Icons.campaign_outlined,
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
