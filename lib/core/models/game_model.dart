class GameModel {
  final String id;
  final String name;
  final String category;
  final String coverUrl;
  final double playTimeHours;
  final String size;
  final DateTime lastPlayed;
  final bool isFavorite;

  const GameModel({
    required this.id,
    required this.name,
    required this.category,
    required this.coverUrl,
    this.playTimeHours = 0.0,
    this.size = '0 MB',
    required this.lastPlayed,
    this.isFavorite = false,
  });

  GameModel copyWith({
    String? id,
    String? name,
    String? category,
    String? coverUrl,
    double? playTimeHours,
    String? size,
    DateTime? lastPlayed,
    bool? isFavorite,
  }) {
    return GameModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      coverUrl: coverUrl ?? this.coverUrl,
      playTimeHours: playTimeHours ?? this.playTimeHours,
      size: size ?? this.size,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
