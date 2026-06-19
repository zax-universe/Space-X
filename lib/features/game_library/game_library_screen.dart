import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/gs_game_card.dart';
import '../../services/mock_data_service.dart';
import 'providers/game_library_provider.dart';

class GameLibraryScreen extends ConsumerWidget {
  const GameLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameLibraryProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/main-background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MY GAMES',
                      style: GSTypography.heading1,
                    ),
                    GestureDetector(
                      onTap: () => _showAddGameSheet(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: GSColors.boostGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: GSColors.backgroundPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SearchBar(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: _CategoryChips(),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => ref.read(gameLibraryProvider.notifier).toggleViewMode(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: state.isGridView
                              ? GSColors.backgroundElevated
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.grid_view,
                          color: state.isGridView
                              ? GSColors.accentYellowGreen
                              : GSColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => ref.read(gameLibraryProvider.notifier).toggleViewMode(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: !state.isGridView
                              ? GSColors.backgroundElevated
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.view_list,
                          color: !state.isGridView
                              ? GSColors.accentYellowGreen
                              : GSColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: state.filteredGames.isEmpty
                    ? _EmptyState()
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: state.isGridView
                            ? _GameGrid(games: state.filteredGames)
                            : _GameList(games: state.filteredGames),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddGameSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _AddGameSheet(),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: GSColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GSColors.borderSubtle),
      ),
      child: TextField(
        controller: _controller,
        style: GSTypography.body.copyWith(color: GSColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search games...',
          hintStyle: GSTypography.body.copyWith(color: GSColors.textMuted),
          prefixIcon: const Icon(Icons.search, color: GSColors.textMuted),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic, color: GSColors.textMuted),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: (value) {
          ref.read(gameLibraryProvider.notifier).setSearchQuery(value);
        },
      ),
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameLibraryProvider);
    final categories = MockDataService.categories;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = state.selectedCategory == category;

        return GestureDetector(
          onTap: () => ref.read(gameLibraryProvider.notifier).setCategory(category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? GSColors.accentYellowGreen : GSColors.backgroundCard,
              borderRadius: BorderRadius.circular(18),
              border: isSelected
                  ? null
                  : Border.all(color: GSColors.borderSubtle),
            ),
            child: Text(
              category,
              style: GSTypography.caption.copyWith(
                color: isSelected ? GSColors.backgroundPrimary : GSColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GameGrid extends StatelessWidget {
  final List games;

  const _GameGrid({required this.games});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return GSGameCard(
          game: games[index],
          isLarge: true,
          onTap: () {},
        );
      },
    );
  }
}

class _GameList extends StatelessWidget {
  final List games;

  const _GameList({required this.games});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: games.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return GSGameListItem(
          game: games[index],
          onTap: () {},
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_esports_outlined,
            size: 64,
            color: GSColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No games found',
            style: GSTypography.heading3,
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: GSTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _AddGameSheet extends StatelessWidget {
  const _AddGameSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: GSColors.backgroundCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: GSColors.backgroundElevated,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Game',
                  style: GSTypography.heading1.copyWith(fontSize: 22),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: GSColors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: MockDataService.games.length,
              itemBuilder: (context, index) {
                final game = MockDataService.games[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      game.coverUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    game.name,
                    style: GSTypography.body.copyWith(color: GSColors.textPrimary),
                  ),
                  subtitle: Text(
                    game.category,
                    style: GSTypography.caption,
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      '+ Add',
                      style: GSTypography.bodySmall.copyWith(
                        color: GSColors.accentYellowGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GSButton(
              text: 'Add Manually',
              isPrimary: false,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
