import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';

class GSBadge extends StatelessWidget {
  final String text;

  const GSBadge({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: GSColors.accentYellowGreen,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GSTypography.label.copyWith(fontSize: 10),
      ),
    );
  }
}
