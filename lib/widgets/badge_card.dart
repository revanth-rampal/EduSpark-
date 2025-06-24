import 'package:flutter/material.dart';
import '../models/badge.dart' as model;
import 'package:google_fonts/google_fonts.dart';

class BadgeCard extends StatelessWidget {
  final model.Badge badge;
  final VoidCallback onSelect;

  const BadgeCard({Key? key, required this.badge, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Badge Image
              Image.asset(
                badge.image,
                height: 80,
              ),
              const Spacer(),
              // Badge Name
              Text(
                badge.name,
                // UPDATED: Ensured text is always centered.
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 4),
              // "Earned" status text
              Text(
                'Earned',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
