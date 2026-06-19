import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';

class GSStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? unit;
  final Color? iconColor;

  const GSStatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.unit,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GSColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GSColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? GSColors.accentYellowGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GSTypography.caption,
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: GSTypography.score.copyWith(fontSize: 24),
          ),
          if (unit != null)
            Text(
              unit!,
              style: GSTypography.caption,
            ),
        ],
      ),
    );
  }
}
