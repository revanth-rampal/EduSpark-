import 'package:flutter/material.dart';
import '../models/badge.dart' as model;
import '../widgets/badge_card.dart';
import '../widgets/badge_detail_dialog.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  void _showBadgeDetails(model.Badge badge) {
    showDialog(
      context: context,
      // Use a custom transition for a smoother appearance
      builder: (context) => FadeTransition(
        opacity: ModalRoute.of(context)!.animation!,
        child: BadgeDetailDialog(badge: badge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badge Collection')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8, // Adjust for better card proportions
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: model.allBadges.length,
        itemBuilder: (context, index) {
          final badge = model.allBadges[index];
          return BadgeCard(
            badge: badge,
            onSelect: () => _showBadgeDetails(badge),
          );
        },
      ),
    );
  }
}
