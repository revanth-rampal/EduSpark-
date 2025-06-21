import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use a ListView to allow the content to scroll if it overflows
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Welcome Section
        const Text(
          'Welcome back, Admin!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Here's what's happening with your school today.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),

        // 2. Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: 'Search students, classes, reports...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 3. Stats Grid - This replicates your DashboardStats.tsx
        GridView.count(
          crossAxisCount: 2, // Two cards per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true, // Important to nest GridView in ListView
          physics:
              const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
          children: const [
            StatCard(
              icon: Icons.people_outline,
              label: 'Total Students',
              value: '1,247',
              change: '+12',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.check_circle_outline,
              label: 'Attendance Rate',
              value: '94.2%',
              change: '+2.1%',
              changeColor: Colors.green,
            ),
            StatCard(
              icon: Icons.star_border,
              label: 'Average Grade',
              value: '87.3',
              change: '-0.5',
              changeColor: Colors.red,
            ),
            StatCard(
              icon: Icons.directions_bus_outlined,
              label: 'Active Buses',
              value: '12',
              change: 'On time',
              changeColor: Colors.grey,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // You can add more sections like "Quick Actions" or "Recent Activity" here later
      ],
    );
  }
}

// Reusable StatCard widget, similar to your React component
class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String change;
  final Color changeColor;

  const StatCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.change,
    required this.changeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.indigo, size: 20),
                ),
                Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
