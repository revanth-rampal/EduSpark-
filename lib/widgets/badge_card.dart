// lib/widgets/badge_card.dart

import 'package:flutter/material.dart';
import 'dart:ui'; // Needed for ImageFilter.blur
import '../models/badge.dart' as model;

class BadgeCard extends StatefulWidget {
  final model.Badge badge;
  final VoidCallback onSelect;

  const BadgeCard({super.key, required this.badge, required this.onSelect});

  @override
  State<BadgeCard> createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard> {
  bool _isElevated = false;

  void _setElevated(bool elevated) {
    // The card can only be elevated if it has been earned
    if (widget.badge.earned) {
      setState(() {
        _isElevated = elevated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // The main card content, which will be styled based on earned status
    Widget cardContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // FIX: The Gradient Gold Glow
            AnimatedOpacity(
              opacity: _isElevated ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.amber.withOpacity(0.5),
                      Colors.orange.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            Image.asset(
              widget.badge.image,
              width: 80,
              height: 80,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.badge.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        // FIX: Only show the "Earned" text if the badge is earned
        if (widget.badge.earned)
          const Text(
            'Earned',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          )
        else
          const Text(
            'Locked',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
      ],
    );

    return AnimatedContainer(
      // FIX: Faster animation duration
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(0, _isElevated ? -8 : 0, 0),
      child: Card(
        elevation: _isElevated ? 12 : 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTapDown: (_) => _setElevated(true),
          onTapUp: (_) => _setElevated(false),
          onTapCancel: () => _setElevated(false),
          onHover: (hovering) => _setElevated(hovering),
          // FIX: Only trigger the onSelect callback if the badge is earned
          onTap: widget.badge.earned ? widget.onSelect : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // FIX: Apply grayscale filter and opacity for unearned badges
            child: widget.badge.earned
                ? cardContent // Show normal content if earned
                : Opacity(
                    opacity: 0.65,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: cardContent,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}