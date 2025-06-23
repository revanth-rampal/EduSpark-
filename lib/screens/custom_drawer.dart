import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';
import 'badges_screen.dart'; // Import the new badges screen

class ChildProfile {
  final String name;
  final String avatarAsset;
  ChildProfile({required this.name, required this.avatarAsset});
}

class CustomDrawer extends StatefulWidget {
  final String userRole;
  const CustomDrawer({Key? key, required this.userRole}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<ChildProfile> _children = [
    ChildProfile(name: "Ananya S.", avatarAsset: "assets/images/user-avatar.png"),
    ChildProfile(name: "Rohan S.", avatarAsset: "assets/images/logo.png"),
  ];
  int _selectedChildIndex = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPrimaryColor = Colors.white;
    final textColor = Colors.grey.shade800;

    return Drawer(
      elevation: 2,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildHeader(context, primaryColor, onPrimaryColor),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                children: [
                  _buildSectionHeader("MENU"),
                  ..._getMenuItemsForRole(context, widget.userRole),
                ],
              ),
            ),
            const Divider(height: 1),
            if (widget.userRole == 'Parent')
              _buildChildSwitcher(),
            _buildFooter(context, textColor),
          ],
        ).animate().fadeIn(duration: 300.ms),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color primaryColor, Color onPrimaryColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(color: primaryColor),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'St Joseph School',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: onPrimaryColor, fontWeight: FontWeight.bold),
              ),
              Text(
                'Sursum Corda',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: onPrimaryColor.withOpacity(0.8)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  List<Widget> _getMenuItemsForRole(BuildContext context, String role) {
    switch (role) {
      case 'Admin':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_rounded, true, () => Navigator.pop(context)),
          _buildMenuItem(context, 'User Management', Icons.people_alt_rounded, false, () {}),
          _buildMenuItem(context, 'Attendance', Icons.assignment_turned_in_rounded, false, () {}),
        ];
      case 'Teacher':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_rounded, true, () => Navigator.pop(context)),
          _buildMenuItem(context, 'Take Attendance', Icons.camera_alt_rounded, false, () {}),
          _buildMenuItem(context, 'My Classes', Icons.class_rounded, false, () {}),
        ];
      case 'Student':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_rounded, true, () => Navigator.pop(context)),
          _buildMenuItem(context, 'My Attendance', Icons.check_circle_rounded, false, () {}),
          // UPDATED: Added the "My Achievements" menu item
          _buildMenuItem(context, 'My Achievements', Icons.workspace_premium_rounded, false, () {
            Navigator.pop(context); // Close the drawer first
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BadgesScreen()));
          }),
          _buildMenuItem(context, 'My Performance', Icons.bar_chart_rounded, false, () {}),
        ];
      case 'Parent':
        return [
          _buildMenuItem(context, 'Dashboard', Icons.dashboard_rounded, true, () => Navigator.pop(context)),
          _buildMenuItem(context, 'Attendance', Icons.check_circle_rounded, false, () {}),
          _buildMenuItem(context, 'Bus Tracking', Icons.directions_bus_rounded, false, () {}),
        ];
      default:
        return [];
    }
  }

  Widget _buildChildSwitcher() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("VIEWING AS", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: List.generate(_children.length, (index) {
                final isSelected = _selectedChildIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedChildIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _children[index].name.split(" ")[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(widget.userRole == 'Parent' ? _children[_selectedChildIndex].avatarAsset : "assets/images/user-avatar.png"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.userRole == 'Parent' ? _children[_selectedChildIndex].name : 'Revanth Rampal',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout_rounded, color: Colors.red.shade400),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, bool isActive, VoidCallback onTap) {
    final primaryColor = Theme.of(context).primaryColor;
    return ListTile(
      leading: Icon(icon, color: isActive ? primaryColor : Colors.grey.shade600),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? primaryColor : Colors.grey.shade800,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      selected: isActive,
      selectedTileColor: primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
