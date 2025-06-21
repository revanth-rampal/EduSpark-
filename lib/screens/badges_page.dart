// lib/screens/badges_page.dart

import 'package:flutter/material.dart';
import '../models/badge.dart' as model;
import '../widgets/badge_card.dart';
import '../widgets/badge_detail_dialog.dart';

class BadgesUIPage extends StatefulWidget {
  const BadgesUIPage({super.key});

  @override
  State<BadgesUIPage> createState() => _BadgesUIPageState();
}

class _BadgesUIPageState extends State<BadgesUIPage> {
  void _showBadgeDetails(model.Badge badge) {
    showDialog(
      context: context,
      builder: (context) => BadgeDetailDialog(badge: badge),
    );
  }

  @override
  Widget build(BuildContext context) {
    final earnedBadges = model.allBadges.where((b) => b.earned).toList();
    earnedBadges.sort((a, b) => b.date.compareTo(a.date));
    final mostRecentBadge = earnedBadges.isNotEmpty ? earnedBadges.first : null;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                children: [
                  const Icon(Icons.emoji_events_outlined,
                      color: Colors.blue, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'My Achievements',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHighlightCard(
                          'Total Badges',
                          earnedBadges.length.toString(),
                          Icons.emoji_events,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildHighlightCard(
                          'Most Recent',
                          mostRecentBadge?.name ?? 'None',
                          Icons.star,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Badge Collection',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // THIS HELPER WIDGET IS NOW CORRECTED
  Widget _buildHighlightCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Reduced padding slightly
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Reduced padding slightly
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28), // Reduced icon size
            ),
            const SizedBox(width: 12),
            // FIX: Wraps the Column in Expanded to make it flexible
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    // These properties prevent text from wrapping awkwardly
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
