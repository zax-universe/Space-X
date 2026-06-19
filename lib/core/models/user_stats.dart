class UserStats {
  final String username;
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final double totalPlayTimeHours;
  final int gamesPlayed;
  final double winRate;
  final int achievements;
  final int highestStreak;
  final List<double> weeklyPlayHours;

  const UserStats({
    this.username = 'GamerPro',
    this.level = 12,
    this.currentXp = 2450,
    this.xpToNextLevel = 3000,
    this.totalPlayTimeHours = 156.5,
    this.gamesPlayed = 24,
    this.winRate = 68.0,
    this.achievements = 156,
    this.highestStreak = 7,
    this.weeklyPlayHours = const [2.5, 4.0, 3.5, 5.0, 2.0, 6.5, 3.0],
  });

  double get xpProgress => currentXp / xpToNextLevel;
}

class Achievement {
  final String id;
  final String name;
  final String iconName;
  final bool isUnlocked;
  final String description;

  const Achievement({
    required this.id,
    required this.name,
    required this.iconName,
    this.isUnlocked = true,
    required this.description,
  });
}
