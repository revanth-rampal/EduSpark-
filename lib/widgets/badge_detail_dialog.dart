import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/badge.dart' as model;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BadgeDetailDialog extends StatelessWidget {
  final model.Badge badge;

  const BadgeDetailDialog({Key? key, required this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            // Larger, floating badge image
            Image.asset(badge.image, height: 120)
                .animate(onPlay: (controller) => controller.repeat())
                .moveY(
                  begin: -5,
                  end: 5,
                  duration: 2.seconds,
                  curve: Curves.easeInOut,
                )
                .then(duration: 2.seconds)
                .moveY(begin: 5, end: -5, curve: Curves.easeInOut),
            const SizedBox(height: 16),
            // Status text
            Text(
              'ACHIEVEMENT UNLOCKED',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            // Badge Name
            Text(
              badge.name,
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              badge.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, height: 1.5, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            // Awarded By and Date Info
            if (badge.earned) ...[
              _buildInfoRow(
                  Icons.person_outline, 'Awarded by: ${badge.awardedBy}'),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.calendar_today_outlined,
                  'Date: ${DateFormat.yMMMd().format(badge.date!)}'),
            ],
          ],
        ).animate().fadeIn(duration: 300.ms),
      ),
    );
  }

  // Helper widget for the info rows at the bottom of the dialog
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
      ],
    );
  }
}
