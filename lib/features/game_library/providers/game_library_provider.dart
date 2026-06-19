import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/game_model.dart';
import '../../../services/mock_data_service.dart';

class GameLibraryState {
  final List<GameModel> games;
  final String searchQuery;
  final String selectedCategory;
  final bool isGridView;
  final bool isSearching;

  const GameLibraryState({
    this.games = const [],
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.isGridView = true,
    this.isSearching = false,
  });

  GameLibraryState copyWith({
    List<GameModel>? games,
    String? searchQuery,
    String? selectedCategory,
    bool? isGridView,
    bool? isSearching,
  }) {
    return GameLibraryState(
      games: games ?? this.games,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isGridView: isGridView ?? this.isGridView,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  List<GameModel> get filteredGames {
    return games.where((game) {
      final matchesSearch = searchQuery.isEmpty ||
          game.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || game.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}

class GameLibraryNotifier extends StateNotifier<GameLibraryState> {
  GameLibraryNotifier() : super(const GameLibraryState()) {
    _loadGames();
  }

  void _loadGames() {
    state = state.copyWith(games: MockDataService.games);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void toggleViewMode() {
    state = state.copyWith(isGridView: !state.isGridView);
  }

  void toggleSearch() {
    state = state.copyWith(isSearching: !state.isSearching, searchQuery: '');
  }
}

final gameLibraryProvider = StateNotifierProvider<GameLibraryNotifier, GameLibraryState>((ref) {
  return GameLibraryNotifier();
});
