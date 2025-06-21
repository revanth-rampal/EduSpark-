import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Using the subtle background pattern for a professional look
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Welcome message is now in the AppBar, so we start with stats
          const Text(
            "Overview",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Statistics Grid
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatCard(
                icon: Icons.people_outline,
                label: 'Total Students',
                value: '1,247',
                change: '+12',
                changeColor: Colors.green,
                iconColor: Colors.blue,
              ),
              _StatCard(
                icon: Icons.check_circle_outline,
                label: 'Attendance',
                value: '94.2%',
                change: '+2.1%',
                changeColor: Colors.green,
                iconColor: Colors.green,
              ),
              _StatCard(
                icon: Icons.star_border,
                label: 'Avg. Grade',
                value: '87.3',
                change: '-0.5',
                changeColor: Colors.red,
                iconColor: Colors.orange,
              ),
              _StatCard(
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

          // Quick Actions Section
          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _ActionCard(
            title: "Manage Users",
            subtitle: "Add, edit, or remove users",
            icon: Icons.people_alt_outlined,
            onTap: () {},
          ),
          _ActionCard(
            title: "Send Notice",
            subtitle: "Broadcast a message to all users",
            icon: Icons.campaign_outlined,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// Reusable StatCard widget for the dashboard overview
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String change;
  final Color changeColor;
  final Color iconColor;

  const _StatCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.change,
    required this.changeColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor),
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
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable ActionCard widget for quick actions
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset('assets/images/action-icon.png', width: 40),
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
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
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
