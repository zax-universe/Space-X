import '../core/models/game_model.dart';
import '../core/models/user_stats.dart';

class MockDataService {
  static final List<GameModel> games = [
    GameModel(
      id: '1',
      name: "Dragon's Ascent",
      category: 'RPG',
      coverUrl: 'assets/images/game-cover-fantasy-rpg.png',
      playTimeHours: 45.5,
      size: '2.4 GB',
      lastPlayed: DateTime.now().subtract(const Duration(hours: 2)),
      isFavorite: true,
    ),
    GameModel(
      id: '2',
      name: 'Neon Drift',
      category: 'Racing',
      coverUrl: 'assets/images/game-cover-racing.png',
      playTimeHours: 23.0,
      size: '1.8 GB',
      lastPlayed: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    GameModel(
      id: '3',
      name: 'Last Stand',
      category: 'Battle Royale',
      coverUrl: 'assets/images/game-cover-battle-royale.png',
      playTimeHours: 67.5,
      size: '3.2 GB',
      lastPlayed: DateTime.now().subtract(const Duration(days: 1)),
      isFavorite: true,
    ),
    GameModel(
      id: '4',
      name: 'Realm Rivals',
      category: 'MOBA',
      coverUrl: 'assets/images/game-cover-moba.png',
      playTimeHours: 89.0,
      size: '2.1 GB',
      lastPlayed: DateTime.now().subtract(const Duration(days: 2)),
    ),
    GameModel(
      id: '5',
      name: 'Nightfall Protocol',
      category: 'Shooter',
      coverUrl: 'assets/images/game-cover-shooter.png',
      playTimeHours: 34.5,
      size: '4.5 GB',
      lastPlayed: DateTime.now().subtract(const Duration(days: 3)),
    ),
    GameModel(
      id: '6',
      name: 'Celestial Chronicles',
      category: 'Puzzle',
      coverUrl: 'assets/images/game-cover-puzzle.png',
      playTimeHours: 12.0,
      size: '890 MB',
      lastPlayed: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  static const UserStats userStats = UserStats();

  static final List<Achievement> achievements = [
    const Achievement(
      id: '1',
      name: 'First Victory',
      iconName: 'emoji_events',
      isUnlocked: true,
      description: 'Win your first match',
    ),
    const Achievement(
      id: '2',
      name: 'Marathon',
      iconName: 'timer',
      isUnlocked: true,
      description: 'Play for 10+ hours in one session',
    ),
    const Achievement(
      id: '3',
      name: 'Speedster',
      iconName: 'bolt',
      isUnlocked: true,
      description: 'Complete a match in under 5 minutes',
    ),
    const Achievement(
      id: '4',
      name: 'Collector',
      iconName: 'collections',
      isUnlocked: false,
      description: 'Add 20 games to your library',
    ),
    const Achievement(
      id: '5',
      name: 'Streak Master',
      iconName: 'local_fire_department',
      isUnlocked: true,
      description: '7-day gaming streak',
    ),
  ];

  static final List<String> categories = [
    'All',
    'Action',
    'RPG',
    'Racing',
    'Battle Royale',
    'MOBA',
    'Shooter',
    'Puzzle',
    'Strategy',
  ];
}
