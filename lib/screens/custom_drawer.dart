import 'package:flutter/material.dart';
import 'login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final String userRole;

  const CustomDrawer({Key? key, required this.userRole}) : super(key: key);

  // This helper function builds the list of menu items based on the user's role.
  List<Widget> _getMenuItems(BuildContext context) {
    switch (userRole) {
      case 'Admin':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_outlined, true,
              () => Navigator.pop(context)),
          _buildExpansionTile(
              context, 'User Management', Icons.people_alt_outlined, [
            _buildSubMenuItem(context, 'Students', () {}),
            _buildSubMenuItem(context, 'Teachers', () {}),
          ]),
          _buildMenuItem(context, 'Attendance',
              Icons.assignment_turned_in_outlined, false, () {}),
          _buildMenuItem(
              context, 'Homework', Icons.book_outlined, false, () {}),
          _buildMenuItem(context, 'Notice Board',
              Icons.notifications_outlined, false, () {}),
        ];
      case 'Teacher':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_outlined, true,
              () => Navigator.pop(context)),
          _buildMenuItem(context, 'Take Attendance', Icons.camera_alt_outlined,
              false, () {}),
          _buildMenuItem(
              context, 'My Classes', Icons.class_outlined, false, () {}),
          _buildMenuItem(context, 'Student Performance',
              Icons.bar_chart_outlined, false, () {}),
        ];
      case 'Student':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_outlined, true,
              () => Navigator.pop(context)),
          _buildMenuItem(context, 'My Attendance',
              Icons.check_circle_outline, false, () {}),
          _buildMenuItem(context, 'My Performance', Icons.bar_chart_outlined,
              false, () {}),
          _buildMenuItem(context, 'Bus Tracking',
              Icons.directions_bus_outlined, false, () {}),
        ];
      default:
        return []; // Return an empty list for unknown roles.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header section for the user profile.
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/user-avatar.png'),
                ),
                const SizedBox(height: 12),
                Text(
                  'Revanth Rampal', // Placeholder Name
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  userRole,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),

          // Scrollable list of menu items.
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getMenuItems(context),
            ),
          ),

          // Footer section with the logout button.
          const Divider(height: 1),
          _buildMenuItem(
            context,
            'Logout',
            Icons.logout,
            false,
            () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Clears the navigation history.
              );
            },
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  // Helper widget for building a standard menu item with modern styling.
  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      bool isActive, VoidCallback onTap,
      {Color? color}) {
    final activeColor = Theme.of(context).primaryColor;
    final itemColor = isActive ? activeColor : (color ?? Colors.grey.shade700);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? activeColor.withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: itemColor),
        title: Text(
          title,
          style: TextStyle(
            color: itemColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Helper widget for building a submenu item.
  Widget _buildSubMenuItem(
      BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.grey.shade600)),
        onTap: onTap,
        dense: true,
      ),
    );
  }

  // Helper widget for building a collapsible menu item (ExpansionTile).
  Widget _buildExpansionTile(
      BuildContext context, String title, IconData icon, List<Widget> children) {
    return Theme(
      // Override the divider color to be transparent.
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.grey.shade700),
          title: Text(title, style: TextStyle(color: Colors.grey.shade700)),
          children: children,
        ),
      ),
    );
  }
}
