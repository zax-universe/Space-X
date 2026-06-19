import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/home/home_screen.dart';
import '../features/game_library/game_library_screen.dart';
import '../features/performance/performance_screen.dart';
import '../features/toolbox/toolbox_screen.dart';
import '../features/profile/profile_screen.dart';
import '../config/colors.dart';

final navigationProvider = StateProvider<int>((ref) => 0);

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    final screens = [
      const HomeScreen(),
      const GameLibraryScreen(),
      const PerformanceScreen(),
      const ToolboxScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: GSColors.backgroundPrimary,
          border: const Border(
            top: BorderSide(color: GSColors.borderSubtle, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  index: 0,
                  currentIndex: currentIndex,
                ),
                _NavItem(
                  icon: Icons.games_rounded,
                  label: 'Library',
                  index: 1,
                  currentIndex: currentIndex,
                ),
                _NavItem(
                  icon: Icons.bolt,
                  label: 'Boost',
                  index: 2,
                  currentIndex: currentIndex,
                ),
                _NavItem(
                  icon: Icons.construction,
                  label: 'Toolbox',
                  index: 3,
                  currentIndex: currentIndex,
                ),
                _NavItem(
                  icon: Icons.person,
                  label: 'Me',
                  index: 4,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        ref.read(navigationProvider.notifier).state = index;
      },
      child: Container(
        width: 60,
        height: 64,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected
                    ? GSColors.accentYellowGreen
                    : GSColors.textMuted,
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? GSColors.accentYellowGreen
                    : GSColors.textMuted,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 4 : 0,
              height: 4,
              decoration: BoxDecoration(
                color: GSColors.accentYellowGreen,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
