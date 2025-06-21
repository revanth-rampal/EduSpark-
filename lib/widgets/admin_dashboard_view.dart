// FILE: lib/views/admin_dashboard_view.dart
// This file defines the UI for the Administrator's dashboard.
// It also contains the reusable DashboardCard widget used by all roles.
// Place this file inside your 'lib/views/' folder.

import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GridView.count creates a 2D scrollable grid of widgets.
    return GridView.count(
      // 'crossAxisCount: 2' means there will be 2 cards per row.
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0), // Padding around the entire grid.
      crossAxisSpacing: 16.0, // Horizontal spacing between cards.
      mainAxisSpacing: 16.0,  // Vertical spacing between cards.
      children: const [
        // Each DashboardCard represents a feature available to the Admin.
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

// A reusable UI component for the dashboard grid items.
// Defining it here allows other dashboard views to import and use it.
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key, 
    required this.icon, 
    required this.title
  }) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    // Using a Card widget for a clean, elevated look.
    return Card(
      child: InkWell( // InkWell provides the tap effect.
        onTap: () {
          // Placeholder action. In a real app, this would navigate to a new screen.
          // For now, it shows a temporary message at the bottom of the screen.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title feature coming soon!'),
              backgroundColor: Colors.indigo,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12), // Ensures the tap effect has rounded corners.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The icon representing the feature.
            Icon(icon, size: 48, color: Colors.indigo),
            const SizedBox(height: 12),
            // The title of the feature.
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
