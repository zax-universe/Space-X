import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/colors.dart';
import '../../config/typography.dart';

class GSModeSelector extends StatelessWidget {
  final List<GSModeItem> modes;
  final int selectedIndex;
  final Function(int) onSelect;

  const GSModeSelector({
    super.key,
    required this.modes,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: GSColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GSColors.borderSubtle),
      ),
      child: Row(
        children: List.generate(modes.length, (index) {
          final mode = modes[index];
          final isSelected = index == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                onSelect(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? GSColors.backgroundElevated
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border(
                          bottom: BorderSide(
                            color: mode.color,
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        mode.icon,
                        color: isSelected ? mode.color : GSColors.textMuted,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mode.label,
                      style: GSTypography.caption.copyWith(
                        color: isSelected
                            ? GSColors.textPrimary
                            : GSColors.textMuted,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class GSModeItem {
  final String label;
  final IconData icon;
  final Color color;

  const GSModeItem({
    required this.label,
    required this.icon,
    required this.color,
  });
}
