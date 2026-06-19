import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../core/widgets/gs_avatar.dart';
import '../../core/widgets/gs_badge.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/gs_game_card.dart';
import '../../core/widgets/gs_mode_selector.dart';
import '../../core/widgets/gs_progress_bar.dart';
import '../../core/widgets/gs_stat_card.dart';
import '../../services/mock_data_service.dart';
import 'providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const _HeaderSection(),
                const SizedBox(height: 24),
                const _QuickBoostCard(),
                const SizedBox(height: 20),
                const _PerformanceModesRow(),
                const SizedBox(height: 24),
                _buildSectionHeader('RECENT GAMES', 'See All'),
                const SizedBox(height: 12),
                const _RecentGamesList(),
                const SizedBox(height: 24),
                _buildSectionHeader('GAMING STATS', null),
                const SizedBox(height: 12),
                const _StatsSummary(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GSTypography.heading3,
        ),
        if (action != null)
          TextButton(
            onPressed: () {},
            child: Text(
              action,
              style: GSTypography.bodySmall.copyWith(
                color: GSColors.accentBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GAME SPACE',
                style: GSTypography.display.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Halo, ',
                    style: GSTypography.body,
                  ),
                  Text(
                    'GamerPro',
                    style: GSTypography.body.copyWith(
                      color: GSColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Row(
          children: [
            GSAvatar(
              imageUrl: 'assets/images/avatar-gamer.png',
              size: 48,
              borderColor: GSColors.accentYellowGreen,
              borderWidth: 2,
            ),
            SizedBox(width: 8),
            Icon(
              Icons.settings_outlined,
              color: GSColors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickBoostCard extends ConsumerWidget {
  const _QuickBoostCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return GSCard(
      useGradient: true,
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getStatusText(state.boostState),
                  style: GSTypography.heading2.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  _getSubText(state.boostState),
                  style: GSTypography.bodySmall,
                ),
                if (state.boostState == BoostState.optimizing) ...[
                  const SizedBox(height: 16),
                  GSProgressBar(
                    value: state.boostProgress,
                    color: GSColors.accentYellowGreen,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.boostProgress.toInt()}%',
                    style: GSTypography.caption.copyWith(
                      color: GSColors.accentYellowGreen,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              notifier.startBoost();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                gradient: state.boostState == BoostState.optimized
                    ? GSColors.boostGradient
                    : null,
                color: state.boostState == BoostState.optimized
                    ? null
                    : GSColors.backgroundElevated,
                shape: BoxShape.circle,
                boxShadow: state.boostState == BoostState.optimizing
                    ? [
                        BoxShadow(
                          color: GSColors.accentYellowGreen.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ]
                    : state.boostState == BoostState.optimized
                        ? [
                            BoxShadow(
                              color: GSColors.accentYellowGreen.withOpacity(0.6),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          ]
                        : null,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: state.boostState == BoostState.optimized
                      ? const Icon(
                          Icons.check,
                          color: GSColors.backgroundPrimary,
                          size: 48,
                          key: ValueKey('check'),
                        )
                      : state.boostState == BoostState.optimizing
                          ? const SizedBox(
                              width: 36,
                              height: 36,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation(
                                  GSColors.accentYellowGreen,
                                ),
                              ),
                              key: ValueKey('loading'),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.bolt,
                                  color: GSColors.accentYellowGreen,
                                  size: 36,
                                ),
                                Text(
                                  'BOOST',
                                  style: GSTypography.label.copyWith(
                                    color: GSColors.accentYellowGreen,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                              key: const ValueKey('idle'),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(BoostState state) {
    switch (state) {
      case BoostState.idle:
        return 'System Ready';
      case BoostState.optimizing:
        return 'Optimizing...';
      case BoostState.optimized:
        return 'Optimized!';
    }
  }

  String _getSubText(BoostState state) {
    switch (state) {
      case BoostState.idle:
        return 'Tap to optimize';
      case BoostState.optimizing:
        return 'Clearing memory...';
      case BoostState.optimized:
        return 'Performance boosted';
    }
  }
}

class _PerformanceModesRow extends ConsumerWidget {
  const _PerformanceModesRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performance = ref.watch(performanceProvider);

    return GSModeSelector(
      modes: const [
        GSModeItem(
          label: 'Balanced',
          icon: Icons.balance,
          color: GSColors.accentBlue,
        ),
        GSModeItem(
          label: 'Pro Gamer',
          icon: Icons.local_fire_department,
          color: GSColors.accentYellowGreen,
        ),
        GSModeItem(
          label: 'Low Power',
          icon: Icons.battery_full,
          color: GSColors.accentOrange,
        ),
      ],
      selectedIndex: performance.mode.index,
      onSelect: (index) {
        HapticFeedback.mediumImpact();
        ref.read(performanceProvider.notifier).setMode(
              PerformanceMode.values[index],
            );
      },
    );
  }
}

class _RecentGamesList extends StatelessWidget {
  const _RecentGamesList();

  @override
  Widget build(BuildContext context) {
    final games = MockDataService.games.take(5).toList();

    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: games.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return AnimatedSlide(
            offset: Offset.zero,
            duration: Duration(milliseconds: 300 + (index * 100)),
            child: GSGameCard(
              game: games[index],
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class _StatsSummary extends StatelessWidget {
  const _StatsSummary();

  @override
  Widget build(BuildContext context) {
    final stats = [
      const GSStatCard(
        icon: Icons.access_time,
        label: 'Play Time',
        value: '12.5H',
        iconColor: GSColors.accentYellowGreen,
      ),
      const GSStatCard(
        icon: Icons.sports_esports,
        label: 'Games',
        value: '24',
        iconColor: GSColors.accentBlue,
      ),
      const GSStatCard(
        icon: Icons.emoji_events,
        label: 'Win Rate',
        value: '68%',
        iconColor: GSColors.accentPurple,
      ),
      const GSStatCard(
        icon: Icons.star,
        label: 'Achievements',
        value: '156',
        iconColor: GSColors.accentOrange,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: stats,
    );
  }
}
