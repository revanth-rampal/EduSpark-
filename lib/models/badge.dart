class Badge {
  final String id;
  final String name;
  final String image;
  final String description;
  final bool earned;
  final String awardedBy;
  final DateTime? date; // Date can be null for unearned badges

  Badge({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.earned,
    this.awardedBy = 'Locked', // Default value for unearned
    this.date,
  });
}

// Dummy data for all available badges in the app, as you provided.
final allBadges = [
  Badge(
    id: 'll',
    name: 'Legendary Learner',
    image: 'assets/images/ll.png',
    description: 'Awarded for demonstrating exceptional curiosity and a deep passion for learning across all subjects.',
    earned: true,
    awardedBy: 'Ms. Davidson',
    date: DateTime.parse('2024-06-15T10:00:00Z'),
  ),
  Badge(
    id: 'ck',
    name: 'Comeback Kid',
    image: 'assets/images/ck.png',
    description: 'Recognizes outstanding creativity and innovation in project work.',
    earned: true,
    awardedBy: 'Mr. Carter',
    date: DateTime.parse('2024-05-22T14:30:00Z'),
  ),
  Badge(
    id: 'som',
    name: 'Star of the Month',
    image: 'assets/images/som.png',
    description: 'Awarded for exemplary behavior and a positive attitude.',
    earned: true,
    awardedBy: 'Principal Adams',
    date: DateTime.parse('2024-04-30T09:00:00Z'),
  ),
  Badge(
    id: 'sc',
    name: 'Sports Champion',
    image: 'assets/images/sc.png',
    description: 'Celebrates exceptional skill and sportsmanship on the field.',
    earned: true,
    awardedBy: 'Coach Miller',
    date: DateTime.parse('2024-03-18T16:00:00Z'),
  ),
  Badge(
    id: 'sw',
    name: 'Science Wizard',
    image: 'assets/images/sw.png',
    description: 'For students who show a remarkable aptitude for scientific inquiry.',
    earned: true,
    awardedBy: 'Dr. Evelyn Reed',
    date: DateTime.parse('2024-02-10T11:00:00Z'),
  ),
  // Unearned Badges
  Badge(
    id: 'pa',
    name: 'Perfect Attendance',
    image: 'assets/images/la.png', // Using the locked asset for all unearned
    description: 'Awarded for not missing a single day of school in a semester.',
    earned: false,
  ),
  Badge(
    id: 'mystery',
    name: 'Mystery Badge',
    image: 'assets/images/la.png', // Using the locked asset
    description: 'Keep participating in class activities to unlock this secret achievement!',
    earned: false,
  ),
];
