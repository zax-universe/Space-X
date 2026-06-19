import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../core/widgets/gs_avatar.dart';
import '../../core/widgets/gs_badge.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/gs_progress_bar.dart';
import 'providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PROFILE',
                      style: GSTypography.heading1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: GSColors.textSecondary),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _ProfileHeader(stats: state.stats),
                const SizedBox(height: 24),
                _buildSectionHeader('ACHIEVEMENTS', 'View All'),
                const SizedBox(height: 12),
                _AchievementsRow(achievements: state.achievements),
                const SizedBox(height: 24),
                _buildSectionHeader('GAMING STATS', null),
                const SizedBox(height: 12),
                _StatsChartCard(weeklyHours: state.stats.weeklyPlayHours),
                const SizedBox(height: 16),
                _DetailedStatsList(stats: state.stats),
                const SizedBox(height: 24),
                _buildSectionHeader('SETTINGS', null),
                const SizedBox(height: 12),
                _SettingsMenuGrid(),
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

class _ProfileHeader extends StatelessWidget {
  final stats;

  const _ProfileHeader({required this.stats});

  @override
  Widget build(BuildContext context) {
    return GSCard(
      useGradient: true,
      child: Column(
        children: [
          Row(
            children: [
              const GSAvatar(
                imageUrl: 'assets/images/avatar-gamer.png',
                size: 72,
                borderColor: GSColors.accentYellowGreen,
                borderWidth: 3,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stats.username,
                          style: GSTypography.heading2,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: GSColors.backgroundElevated,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: GSColors.textSecondary,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GSBadge(text: 'Level ${stats.level}'),
                        const SizedBox(width: 8),
                        Text(
                          '${stats.currentXp} / ${stats.xpToNextLevel} XP',
                          style: GSTypography.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GSProgressBar(
            value: stats.xpProgress * 100,
            color: GSColors.accentYellowGreen,
            height: 8,
          ),
        ],
      ),
    );
  }
}

class _AchievementsRow extends StatelessWidget {
  final achievements;

  const _AchievementsRow({required this.achievements});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: achievements.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Container(
            width: 82,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: GSColors.backgroundCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: GSColors.borderSubtle),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getIconData(achievement.iconName),
                  color: achievement.isUnlocked
                      ? Colors.amber
                      : GSColors.textMuted,
                  size: 36,
                ),
                const SizedBox(height: 6),
                Text(
                  achievement.name,
                  style: GSTypography.caption.copyWith(
                    fontSize: 10,
                    color: achievement.isUnlocked
                        ? GSColors.textPrimary
                        : GSColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!achievement.isUnlocked)
                  const Icon(Icons.lock, color: GSColors.textMuted, size: 12),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getIconData(String name) {
    switch (name) {
      case 'emoji_events':
        return Icons.emoji_events;
      case 'timer':
        return Icons.timer;
      case 'bolt':
        return Icons.bolt;
      case 'collections':
        return Icons.collections;
      case 'local_fire_department':
        return Icons.local_fire_department;
      default:
        return Icons.star;
    }
  }
}

class _StatsChartCard extends StatelessWidget {
  final List<double> weeklyHours;

  const _StatsChartCard({required this.weeklyHours});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return GSCard(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Play Time',
            style: GSTypography.heading3.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 8,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value >= days.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[value.toInt()],
                            style: GSTypography.caption.copyWith(fontSize: 10),
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}h',
                          style: GSTypography.caption.copyWith(fontSize: 10),
                        );
                      },
                      reservedSize: 28,
                      interval: 2,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: weeklyHours.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        color: GSColors.accentYellowGreen,
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 8,
                          color: GSColors.backgroundElevated,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailedStatsList extends StatelessWidget {
  final stats;

  const _DetailedStatsList({required this.stats});

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItemData(
          icon: Icons.access_time, label: 'Total Play Time', value: '${stats.totalPlayTimeHours}H'),
      _StatItemData(
          icon: Icons.games, label: 'Games Completed', value: '${stats.gamesPlayed}'),
      _StatItemData(
          icon: Icons.emoji_events, label: 'Win Rate', value: '${stats.winRate}%'),
      _StatItemData(
          icon: Icons.local_fire_department, label: 'Highest Streak', value: '${stats.highestStreak} days'),
    ];

    return GSCard(
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          return Column(
            children: [
              if (entry.key > 0)
                const Divider(color: GSColors.borderSubtle, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Icon(item.icon, color: GSColors.accentBlue, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.label,
                        style: GSTypography.body.copyWith(color: GSColors.textPrimary),
                      ),
                    ),
                    Text(
                      item.value,
                      style: GSTypography.body.copyWith(
                        color: GSColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, color: GSColors.textMuted, size: 18),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _StatItemData {
  final IconData icon;
  final String label;
  final String value;

  _StatItemData({required this.icon, required this.label, required this.value});
}

class _SettingsMenuGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      _SettingItem(icon: Icons.person_outline, label: 'Account', color: GSColors.accentBlue),
      _SettingItem(icon: Icons.notifications_none, label: 'Notifications', color: GSColors.accentYellowGreen),
      _SettingItem(icon: Icons.palette_outlined, label: 'Theme', color: GSColors.accentPurple),
      _SettingItem(icon: Icons.language, label: 'Language', color: GSColors.accentOrange),
      _SettingItem(icon: Icons.info_outline, label: 'About', color: GSColors.accentBlue),
      _SettingItem(icon: Icons.help_outline, label: 'Help', color: GSColors.accentYellowGreen),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: items.map((item) => _SettingCard(item: item)).toList(),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String label;
  final Color color;

  _SettingItem({required this.icon, required this.label, required this.color});
}

class _SettingCard extends StatelessWidget {
  final _SettingItem item;

  const _SettingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: GSColors.backgroundCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: GSColors.borderSubtle),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: item.color, size: 28),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: GSTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}
