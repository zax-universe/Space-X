import 'package:flutter/material.dart';
import '../../config/colors.dart';

enum PerformanceMode {
  balanced,
  proGamer,
  lowPower,
}

extension PerformanceModeExtension on PerformanceMode {
  String get label {
    switch (this) {
      case PerformanceMode.balanced:
        return 'Balanced';
      case PerformanceMode.proGamer:
        return 'Pro Gamer';
      case PerformanceMode.lowPower:
        return 'Low Power';
    }
  }

  String get description {
    switch (this) {
      case PerformanceMode.balanced:
        return 'Best of both worlds';
      case PerformanceMode.proGamer:
        return 'Maximum performance';
      case PerformanceMode.lowPower:
        return 'Extend play time';
    }
  }

  IconData get icon {
    switch (this) {
      case PerformanceMode.balanced:
        return Icons.balance;
      case PerformanceMode.proGamer:
        return Icons.local_fire_department;
      case PerformanceMode.lowPower:
        return Icons.battery_full;
    }
  }

  Color get color {
    switch (this) {
      case PerformanceMode.balanced:
        return GSColors.accentBlue;
      case PerformanceMode.proGamer:
        return GSColors.accentYellowGreen;
      case PerformanceMode.lowPower:
        return GSColors.accentOrange;
    }
  }

  double get targetCpu {
    switch (this) {
      case PerformanceMode.balanced:
        return 50;
      case PerformanceMode.proGamer:
        return 85;
      case PerformanceMode.lowPower:
        return 30;
    }
  }

  double get targetGpu {
    switch (this) {
      case PerformanceMode.balanced:
        return 55;
      case PerformanceMode.proGamer:
        return 90;
      case PerformanceMode.lowPower:
        return 25;
    }
  }

  double get targetRam {
    switch (this) {
      case PerformanceMode.balanced:
        return 60;
      case PerformanceMode.proGamer:
        return 80;
      case PerformanceMode.lowPower:
        return 40;
    }
  }
}
