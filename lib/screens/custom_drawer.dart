import 'package:flutter/material.dart';
import 'login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final String userRole;

  const CustomDrawer({Key? key, required this.userRole}) : super(key: key);

  List<Widget> _getMenuItems(BuildContext context) {
    List<Widget> menuItems = [];

    switch (userRole) {
      case 'Admin':
        menuItems.addAll([
          _buildMenuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () => Navigator.pop(context),
          ),
          ExpansionTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('User Management'),
            children: [
              _buildSubMenuItem(
                context,
                icon: Icons.school_outlined,
                title: 'Students',
                onTap: () {},
              ),
              _buildSubMenuItem(
                context,
                icon: Icons.person_outline,
                title: 'Teachers',
                onTap: () {},
              ),
            ],
          ),
          _buildMenuItem(
            context,
            icon: Icons.assignment_outlined,
            title: 'Attendance',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.book_outlined,
            title: 'Homework',
            onTap: () {},
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),
        ]);
        break;
      case 'Teacher':
        menuItems.addAll([
          _buildMenuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () => Navigator.pop(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.camera_alt_outlined,
            title: 'Mark Attendance',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            // CORRECTED: Changed from class__outlined to class_outlined
            icon: Icons.class_outlined,
            title: 'My Classes',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.bar_chart_outlined,
            title: 'Student Performance',
            onTap: () {},
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {},
          ),
        ]);
        break;
      case 'Student':
        menuItems.addAll([
          _buildMenuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () => Navigator.pop(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.check_circle_outline,
            title: 'My Attendance',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.bar_chart_outlined,
            title: 'My Performance',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.directions_bus_outlined,
            title: 'Bus Tracking',
            onTap: () {},
          ),
        ]);
        break;
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Revanth Rampal',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              '$userRole Account',
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=100'),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getMenuItems(context),
            ),
          ),
          const Divider(),
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }

  // CORRECTED: Fixed typo from BuildContext- to BuildContext
  Widget _buildSubMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: ListTile(
        leading: Icon(icon, size: 20),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
