import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_stats.dart';
import '../../../services/mock_data_service.dart';

class ProfileState {
  final UserStats stats;
  final List<Achievement> achievements;

  const ProfileState({
    this.stats = MockDataService.userStats,
    this.achievements = const [],
  });

  ProfileState copyWith({
    UserStats? stats,
    List<Achievement>? achievements,
  }) {
    return ProfileState(
      stats: stats ?? this.stats,
      achievements: achievements ?? this.achievements,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState()) {
    _loadAchievements();
  }

  void _loadAchievements() {
    state = state.copyWith(achievements: MockDataService.achievements);
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
