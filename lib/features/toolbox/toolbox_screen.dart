import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/gs_toggle.dart';
import 'providers/toolbox_provider.dart';

class ToolboxScreen extends ConsumerWidget {
  const ToolboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(toolboxProvider);

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
                      'TOOLBOX',
                      style: GSTypography.heading1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: GSColors.textSecondary),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const _ActiveGameCard(),
                const SizedBox(height: 24),
                Text(
                  'QUICK TOOLS',
                  style: GSTypography.heading3,
                ),
                const SizedBox(height: 12),
                _QuickToolsGrid(),
                const SizedBox(height: 24),
                GSCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Floating Toolbox',
                            style: GSTypography.body.copyWith(
                                color: GSColors.textPrimary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quick access during gameplay',
                            style: GSTypography.caption,
                          ),
                        ],
                      ),
                      GSToggle(
                        value: state.floatingToolboxEnabled,
                        onChanged: (_) => ref
                            .read(toolboxProvider.notifier)
                            .toggleFloatingToolbox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'ADVANCED TOOLS',
                  style: GSTypography.heading3,
                ),
                const SizedBox(height: 12),
                _AdvancedToolsGrid(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActiveGameCard extends StatelessWidget {
  const _ActiveGameCard();

  @override
  Widget build(BuildContext context) {
    return GSCard(
      height: 100,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/game-cover-fantasy-rpg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    GSColors.backgroundPrimary.withOpacity(0.9),
                    GSColors.backgroundPrimary.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/game-cover-fantasy-rpg.png',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Playing Now',
                          style: GSTypography.caption,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Dragon's Ascent",
                          style: GSTypography.heading2.copyWith(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: GSColors.boostGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: GSColors.accentYellowGreen.withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.pause,
                      color: GSColors.backgroundPrimary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickToolsGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(toolboxProvider);
    final notifier = ref.read(toolboxProvider.notifier);

    final tools = [
      _ToolData(
        icon: Icons.notifications_off,
        label: 'DND',
        isActive: state.dndEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleDnd();
        },
        activeColor: GSColors.accentOrange,
      ),
      _ToolData(
        icon: Icons.phone_disabled,
        label: 'Block Calls',
        isActive: state.blockCallsEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleBlockCalls();
        },
        activeColor: GSColors.accentPurple,
      ),
      _ToolData(
        icon: Icons.camera_alt,
        label: 'Screenshot',
        isActive: state.screenshotEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleScreenshot();
        },
        activeColor: GSColors.accentBlue,
      ),
      _ToolData(
        icon: Icons.videocam,
        label: 'Record',
        isActive: state.screenRecordEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleScreenRecord();
        },
        activeColor: GSColors.accentOrange,
      ),
      _ToolData(
        icon: Icons.mic,
        label: 'Voice',
        isActive: state.voiceChangerEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleVoiceChanger();
        },
        activeColor: GSColors.accentPurple,
      ),
      _ToolData(
        icon: Icons.wb_sunny,
        label: 'Brightness',
        isActive: state.brightnessLockEnabled,
        onTap: () {
          HapticFeedback.lightImpact();
          notifier.toggleBrightnessLock();
        },
        activeColor: GSColors.accentYellowGreen,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: tools.map((tool) => _ToolButton(tool: tool)).toList(),
    );
  }
}

class _ToolData {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;

  _ToolData({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
  });
}

class _ToolButton extends StatelessWidget {
  final _ToolData tool;

  const _ToolButton({required this.tool});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tool.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: tool.isActive ? GSColors.backgroundElevated : GSColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tool.isActive ? tool.activeColor : GSColors.borderSubtle,
            width: tool.isActive ? 2 : 1,
          ),
          boxShadow: tool.isActive
              ? [
                  BoxShadow(
                    color: tool.activeColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: tool.isActive ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                tool.icon,
                color: tool.isActive ? tool.activeColor : GSColors.textMuted,
                size: 36,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tool.label,
              style: GSTypography.caption.copyWith(
                color: tool.isActive ? GSColors.textPrimary : GSColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedToolsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tools = [
      _AdvToolData(icon: Icons.adjust, label: 'Crosshair', color: GSColors.accentBlue),
      _AdvToolData(icon: Icons.lock_clock, label: 'FPS Lock', color: GSColors.accentPurple),
      _AdvToolData(icon: Icons.keyboard, label: 'Macro', color: GSColors.accentYellowGreen),
      _AdvToolData(icon: Icons.bolt, label: 'Speed Up', color: GSColors.accentOrange),
      _AdvToolData(icon: Icons.cleaning_services, label: 'Cleaner', color: GSColors.accentBlue),
      _AdvToolData(icon: Icons.trending_down, label: 'Lag Fix', color: GSColors.accentPurple),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: tools.map((tool) => _AdvToolButton(tool: tool)).toList(),
    );
  }
}

class _AdvToolData {
  final IconData icon;
  final String label;
  final Color color;

  _AdvToolData({required this.icon, required this.label, required this.color});
}

class _AdvToolButton extends StatelessWidget {
  final _AdvToolData tool;

  const _AdvToolButton({required this.tool});

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
            Icon(tool.icon, color: tool.color, size: 28),
            const SizedBox(height: 6),
            Text(
              tool.label,
              style: GSTypography.caption.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
