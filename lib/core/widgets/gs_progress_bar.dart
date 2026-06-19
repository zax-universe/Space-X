import 'package:flutter/material.dart';
import '../../config/colors.dart';

class GSProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final Color? color;
  final bool animated;

  const GSProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.color,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = color ?? GSColors.getUsageColor(value);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: GSColors.backgroundElevated,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: AnimatedContainer(
        duration: animated
            ? const Duration(milliseconds: 800)
            : Duration.zero,
        curve: Curves.easeOutCubic,
        width: (value / 100) * MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              fillColor.withOpacity(0.7),
              fillColor,
            ],
          ),
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: [
            BoxShadow(
              color: fillColor.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
