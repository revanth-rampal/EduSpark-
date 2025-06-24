import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      // The AppBar is now styled to blend with the gradient background.
      appBar: AppBar(
        title: const Text("Student Profile"),
        backgroundColor: primaryColor.withOpacity(0.1), // Matches the top of the gradient
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        // The gradient now covers the entire body.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withOpacity(0.1), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // UPDATED: The ListView is now wrapped in a SafeArea widget.
        // This automatically adds padding to avoid the top and bottom system bars.
        child: SafeArea(
          top: false, // We don't need top padding because the AppBar handles that area.
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              // The header no longer needs a manual spacer.
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildInfoCard(
                title: 'Personal Information',
                icon: Icons.person_outline,
                children: [
                  _buildInfoRow(Icons.cake_outlined, 'Date of Birth', '15 Aug 2008'),
                  _buildInfoRow(Icons.bloodtype_outlined, 'Blood Group', 'O+'),
                ],
              ),
              _buildInfoCard(
                title: 'Address',
                icon: Icons.home_outlined,
                children: [
                  _buildInfoRow(Icons.location_on_outlined, 'Street', '123, Main Street'),
                  _buildInfoRow(Icons.location_city_outlined, 'City', 'Rajamahendravaram'),
                  _buildInfoRow(Icons.map_outlined, 'Postal Code', '533101'),
                ],
              ),
              _buildInfoCard(
                title: 'Emergency Contact',
                icon: Icons.contact_emergency_outlined,
                children: [
                  _buildInfoRow(Icons.person_pin_outlined, 'Name', 'Anand Kumar'),
                  _buildInfoRow(Icons.family_restroom_outlined, 'Relationship', 'Father'),
                  _buildInfoRow(Icons.phone_outlined, 'Phone', '+91 98765 43210'),
                ],
              ),
            ].animate(interval: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // REMOVED: The SizedBox(height: 100) is no longer needed.
        const SizedBox(height: 20), // A smaller, consistent padding.
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/user-avatar.png'),
        ),
        const SizedBox(height: 16),
        Text(
          'Revanth Rampal',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Student ID: 12345',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade500),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
