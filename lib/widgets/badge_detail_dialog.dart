// lib/widgets/badge_detail_dialog.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/badge.dart' as model;

class BadgeDetailDialog extends StatefulWidget {
  final model.Badge badge;

  const BadgeDetailDialog({super.key, required this.badge});

  @override
  State<BadgeDetailDialog> createState() => _BadgeDetailDialogState();
}

class _BadgeDetailDialogState extends State<BadgeDetailDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  // FIX: Changed the animation to control a 'double' value (for pixels)
  // instead of a fractional 'Offset'. This gives us more control.
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Slightly faster duration
    )..repeat(reverse: true);

    // FIX: The animation now tweens between 0 and -12 pixels vertically.
    _animation = Tween<double>(begin: 0, end: -12.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        // ... (container decoration is the same)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // FIX: Using AnimatedBuilder for a smooth, custom transform.
                      // This is more efficient for complex animations.
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.translate(
                            // The offset uses the animated value directly.
                            offset: Offset(0, _animation.value),
                            child: child,
                          );
                        },
                        child: Image.asset(widget.badge.image,
                            width: 150, height: 150),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Achievement Unlocked',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.badge.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.badge.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow(Icons.person_outline, 'Awarded by',
                          widget.badge.awardedBy),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                          Icons.calendar_today_outlined,
                          'Date',
                          widget.badge.date != null ? DateFormat.yMMMd().format(widget.badge.date!) : 'N/A'
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -16,
                  right: -16,
                  child: Material(
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}