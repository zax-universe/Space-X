import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';
import '../../core/models/performance_mode.dart';
import '../../core/widgets/gs_card.dart';
import '../../core/widgets/gs_button.dart';
import '../../core/widgets/gs_progress_bar.dart';
import '../../core/widgets/gs_toggle.dart';
import 'providers/performance_provider.dart';

class PerformanceScreen extends ConsumerWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(performanceProvider);

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
                      'PERFORMANCE',
                      style: GSTypography.heading1,
                    ),
                    IconButton(
                      icon: const Icon(Icons.history, color: GSColors.textSecondary),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SystemStatusCard(),
                const SizedBox(height: 20),
                _ModeSelectionCards(),
                const SizedBox(height: 20),
                _NetworkOptimizerCard(),
                const SizedBox(height: 20),
                _BoostSettingsList(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SystemStatusCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(performanceProvider);

    return GSCard(
      useGradient: true,
      child: Column(
        children: [
          _MonitorRow(
            icon: Icons.memory,
            label: 'CPU',
            value: state.cpuUsage,
            color: GSColors.accentBlue,
            unit: '%',
          ),
          const SizedBox(height: 12),
          _MonitorRow(
            icon: Icons.videogame_asset,
            label: 'GPU',
            value: state.gpuUsage,
            color: GSColors.accentPurple,
            unit: '%',
          ),
          const SizedBox(height: 12),
          _MonitorRow(
            icon: Icons.storage,
            label: 'RAM',
            value: state.ramUsage,
            color: GSColors.accentYellowGreen,
            unit: '%',
          ),
          const SizedBox(height: 16),
          _TemperatureGauge(temperature: state.temperature),
        ],
      ),
    );
  }
}

class _MonitorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final Color color;
  final String unit;

  const _MonitorRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: GSTypography.body.copyWith(color: GSColors.textPrimary),
          ),
        ),
        Expanded(
          child: GSProgressBar(
            value: value,
            color: color,
            height: 8,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 45,
          child: Text(
            '${value.toInt()}$unit',
            style: GSTypography.score.copyWith(fontSize: 16, color: color),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _TemperatureGauge extends StatelessWidget {
  final double temperature;

  const _TemperatureGauge({required this.temperature});

  @override
  Widget build(BuildContext context) {
    final percent = (temperature - 30) / 50;
    final clampedPercent = percent.clamp(0.0, 1.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
            painter: _TemperaturePainter(
              percent: clampedPercent,
              temperature: temperature,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature',
              style: GSTypography.caption,
            ),
            const SizedBox(height: 4),
            Text(
              '${temperature.toInt()}°C',
              style: GSTypography.heading2.copyWith(
                color: GSColors.getUsageColor(clampedPercent * 100),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              clampedPercent < 0.4
                  ? 'Cool'
                  : clampedPercent < 0.7
                      ? 'Normal'
                      : 'Hot',
              style: GSTypography.caption.copyWith(
                color: GSColors.getUsageColor(clampedPercent * 100),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TemperaturePainter extends CustomPainter {
  final double percent;
  final double temperature;

  _TemperaturePainter({required this.percent, required this.temperature});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final strokeWidth = 6.0;

    // Background arc
    final bgPaint = Paint()
      ..color = GSColors.backgroundElevated
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14 * 0.75,
      3.14 * 1.5,
      false,
      bgPaint,
    );

    // Fill arc
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          GSColors.accentBlue,
          GSColors.accentYellowGreen,
          GSColors.accentOrange,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14 * 0.75,
      3.14 * 1.5 * percent,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ModeSelectionCards extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(performanceProvider);

    return Row(
      children: PerformanceMode.values.map((mode) {
        final isSelected = state.mode == mode;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              ref.read(performanceProvider.notifier).setMode(mode);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isSelected ? GSColors.cardGlow : null,
                color: isSelected ? null : GSColors.backgroundCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? mode.color : GSColors.borderSubtle,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: mode.color.withOpacity(0.3),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(mode.icon, color: mode.color, size: 36),
                  const SizedBox(height: 8),
                  Text(
                    mode.label,
                    style: GSTypography.caption.copyWith(
                      color: GSColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mode.description,
                    style: GSTypography.label.copyWith(fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _NetworkOptimizerCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final network = ref.watch(networkProvider);
    final networkNotifier = ref.read(networkProvider.notifier);

    return GSCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.network_check, color: GSColors.accentBlue, size: 22),
              const SizedBox(width: 8),
              Text(
                'Network',
                style: GSTypography.heading3.copyWith(fontSize: 16),
              ),
              const Spacer(),
              Icon(Icons.signal_cellular_alt,
                  color: GSColors.accentYellowGreen, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NetworkStat(label: 'Ping', value: '${network.ping}ms', color: GSColors.accentYellowGreen),
              _NetworkStat(label: 'Jitter', value: '${network.jitter}ms', color: GSColors.accentBlue),
              _NetworkStat(label: 'Loss', value: '${network.loss}%', color: GSColors.accentYellowGreen),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: GSButton(
              text: network.isOptimizing ? 'Optimizing...' : 'Optimize Network',
              isLoading: network.isOptimizing,
              onPressed: () => networkNotifier.optimize(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _NetworkStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GSTypography.score.copyWith(fontSize: 22, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GSTypography.caption,
        ),
      ],
    );
  }
}

class _BoostSettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = [
      _BoostSetting(title: 'Auto-boost on game launch', value: true),
      _BoostSetting(title: 'Block notifications', value: true),
      _BoostSetting(title: 'Priority network', value: false),
      _BoostSetting(title: 'Lock brightness', value: true),
    ];

    return GSCard(
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final setting = entry.value;
          return Column(
            children: [
              if (entry.key > 0)
                const Divider(color: GSColors.borderSubtle, height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      setting.title,
                      style: GSTypography.body.copyWith(color: GSColors.textPrimary),
                    ),
                    GSToggle(
                      value: setting.value,
                      onChanged: (_) {},
                    ),
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

class _BoostSetting {
  final String title;
  final bool value;

  _BoostSetting({required this.title, required this.value});
}
