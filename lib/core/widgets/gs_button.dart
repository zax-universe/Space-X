import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';

class GSButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;

  const GSButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52,
  });

  @override
  State<GSButton> createState() => _GSButtonState();
}

class _GSButtonState extends State<GSButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        transform: Matrix4.identity()..scale(_pressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          gradient: widget.isPrimary ? GSColors.boostGradient : null,
          color: widget.isPrimary ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: widget.isPrimary
              ? null
              : Border.all(color: GSColors.accentYellowGreen, width: 1.5),
          boxShadow: widget.isPrimary && !_pressed
              ? [
                  BoxShadow(
                    color: GSColors.accentYellowGreen.withOpacity(0.3),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: widget.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(GSColors.backgroundPrimary),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        size: 20,
                        color: widget.isPrimary
                            ? GSColors.backgroundPrimary
                            : GSColors.accentYellowGreen,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: GSTypography.heading3.copyWith(
                        color: widget.isPrimary
                            ? GSColors.backgroundPrimary
                            : GSColors.accentYellowGreen,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
