// lib/models/badge.dart

class Badge {
  final String id;
  final String name;
  final String image;
  final String description;
  final bool earned;
  final String awardedBy;
  final DateTime date;

  Badge({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.earned,
    required this.awardedBy,
    required this.date,
  });
}

// --- MOCK DATA ---
// This list translates your React mock data.
final allBadges = [
  Badge(
    id: 'll',
    name: 'Legendary Learner',
    image: 'assets/images/ll.png', // Note the updated path for Flutter
    description:
        'Awarded for demonstrating exceptional curiosity and a deep passion for learning across all subjects. A true role model in the classroom.',
    earned: true,
    awardedBy: 'Ms. Davidson',
    date: DateTime.parse('2024-06-15T10:00:00Z'),
  ),
  Badge(
    id: 'ck',
    name: 'Comeback Kid',
    image: 'assets/images/ck.png',
    description:
        'Recognizes outstanding creativity and innovation in project work, thinking outside the box to produce extraordinary results.',
    earned: true,
    awardedBy: 'Mr. Carter',
    date: DateTime.parse('2024-05-22T14:30:00Z'),
  ),
  Badge(
    id: 'som',
    name: 'Star of the Month',
    image: 'assets/images/som.png',
    description:
        'Awarded for exemplary behavior, consistent effort, and a positive attitude throughout the entire month.',
    earned: true,
    awardedBy: 'Principal Adams',
    date: DateTime.parse('2024-04-30T09:00:00Z'),
  ),
  Badge(
    id: 'sc',
    name: 'Sports Champion',
    image: 'assets/images/sc.png',
    description:
        'Celebrates exceptional skill, sportsmanship, and leadership on the sports field. A true team player.',
    earned: true,
    awardedBy: 'Coach Miller',
    date: DateTime.parse('2024-03-18T16:00:00Z'),
  ),
  Badge(
    id: 'sw',
    name: 'Science Wizard',
    image: 'assets/images/sw.png',
    description:
        'For students who show a remarkable aptitude for scientific inquiry, experimentation, and discovery.',
    earned: true,
    awardedBy: 'Dr. Evelyn Reed',
    date: DateTime.parse('2024-02-10T11:00:00Z'),
  ),
];
