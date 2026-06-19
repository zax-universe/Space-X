import 'package:flutter/material.dart';

class GSColors {
  GSColors._();

  static const Color backgroundPrimary = Color(0xFF050B14);
  static const Color backgroundCard = Color(0xFF0A1628);
  static const Color backgroundElevated = Color(0xFF111D32);
  static const Color accentYellowGreen = Color(0xFFD4FF00);
  static const Color accentBlue = Color(0xFF2563EB);
  static const Color accentOrange = Color(0xFFFF6B00);
  static const Color accentPurple = Color(0xFF9333EA);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);
  static const Color borderSubtle = Color(0xFF1E293B);
  static const Color overlay = Color(0xB3000000);

  static const LinearGradient cardGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A1628),
      Color(0xFF111D32),
      Color(0xFF0D1E3C),
    ],
  );

  static const LinearGradient boostGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD4FF00),
      Color(0xFFA3E600),
    ],
  );

  static const LinearGradient headerFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF050B14),
      Colors.transparent,
    ],
  );

  static const LinearGradient bottomFade = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xFF050B14),
      Colors.transparent,
    ],
  );

  static Color getUsageColor(double percent) {
    if (percent < 50) return accentBlue;
    if (percent < 80) return accentYellowGreen;
    return accentOrange;
  }
}
