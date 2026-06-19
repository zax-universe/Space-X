import 'package:flutter/material.dart';
import '../../config/colors.dart';

class GSCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double borderRadius;
  final bool useGradient;
  final VoidCallback? onTap;
  final Border? border;

  const GSCard({
    super.key,
    required this.child,
    this.padding,
    this.height,
    this.borderRadius = 16,
    this.useGradient = false,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: useGradient ? GSColors.cardGlow : null,
        color: useGradient ? null : GSColors.backgroundCard,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ?? Border.all(color: GSColors.borderSubtle, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
