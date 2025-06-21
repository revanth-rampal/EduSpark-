// lib/screens/badges_page.dart

import 'package:flutter/material.dart';
import '../models/badge.dart' as model; // This line is correct!
import '../widgets/badge_card.dart';
import '../widgets/badge_detail_dialog.dart';

class BadgesUIPage extends StatefulWidget {
  const BadgesUIPage({super.key});

  @override
  State<BadgesUIPage> createState() => _BadgesUIPageState();
}

class _BadgesUIPageState extends State<BadgesUIPage> {
  // This function shows the dialog. It's the equivalent of setSelectedBadge in React.
  // FIX 1: The 'Badge' type now uses the 'model' prefix.
  void _showBadgeDetails(model.Badge badge) {
    showDialog(
      context: context,
      builder: (context) => BadgeDetailDialog(badge: badge),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Logic for counts and most recent badge
    // FIX 2: Access the 'allBadges' list using the 'model' prefix.
    final earnedBadges = model.allBadges.where((b) => b.earned).toList();
    earnedBadges.sort((a, b) => b.date.compareTo(a.date));
    final mostRecentBadge = earnedBadges.isNotEmpty ? earnedBadges.first : null;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
          child