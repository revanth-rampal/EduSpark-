import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: const [
        DashboardCard(
          icon: Icons.manage_accounts_rounded,
          title: 'Manage Teachers',
        ),
        DashboardCard(
          icon: Icons.people_alt_rounded,
          title: 'Manage Students',
        ),
        DashboardCard(
          icon: Icons.bar_chart_rounded,
          title: 'View Reports',
        ),
        DashboardCard(
          icon: Icons.notifications_active_rounded,
          title: 'Send Alerts',
        ),
        DashboardCard(
          icon: Icons.class_rounded,
          title: 'Manage Classes',
        ),
        DashboardCard(
          icon: Icons.settings_rounded,
          title: 'System Settings',
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title feature coming soon!'),
              backgroundColor: Colors.indigo,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
