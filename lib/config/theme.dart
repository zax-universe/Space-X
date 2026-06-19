import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';

class GSTheme {
  GSTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: GSColors.backgroundPrimary,
      colorScheme: const ColorScheme.dark(
        primary: GSColors.accentYellowGreen,
        secondary: GSColors.accentBlue,
        surface: GSColors.backgroundCard,
        background: GSColors.backgroundPrimary,
        error: GSColors.accentOrange,
        onPrimary: GSColors.backgroundPrimary,
        onSecondary: Colors.white,
        onSurface: GSColors.textPrimary,
        onBackground: GSColors.textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: GSTypography.display,
        headlineLarge: GSTypography.heading1,
        headlineMedium: GSTypography.heading2,
        headlineSmall: GSTypography.heading3,
        bodyLarge: GSTypography.body,
        bodyMedium: GSTypography.bodySmall,
        bodySmall: GSTypography.caption,
        labelSmall: GSTypography.label,
      ),
      cardTheme: CardTheme(
        color: GSColors.backgroundCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.4),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: GSColors.backgroundPrimary,
        selectedItemColor: GSColors.accentYellowGreen,
        unselectedItemColor: GSColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      dividerTheme: const DividerThemeData(
        color: GSColors.borderSubtle,
        thickness: 1,
      ),
      splashColor: GSColors.accentYellowGreen.withOpacity(0.1),
      highlightColor: Colors.transparent,
    );
  }
}
