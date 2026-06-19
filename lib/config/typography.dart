import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class GSTypography {
  GSTypography._();

  static TextStyle display = GoogleFonts.orbitron(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 1.1,
    color: GSColors.textPrimary,
  );

  static TextStyle heading1 = GoogleFonts.orbitron(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: GSColors.textPrimary,
  );

  static TextStyle heading2 = GoogleFonts.orbitron(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: GSColors.textPrimary,
  );

  static TextStyle heading3 = GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.3,
    color: GSColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.rajdhani(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.5,
    color: GSColors.textSecondary,
  );

  static TextStyle bodySmall = GoogleFonts.rajdhani(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 1.4,
    color: GSColors.textSecondary,
  );

  static TextStyle caption = GoogleFonts.rajdhani(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
    color: GSColors.textSecondary,
  );

  static TextStyle label = GoogleFonts.rajdhani(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    height: 1.2,
    color: GSColors.textSecondary,
  );

  static TextStyle timer = GoogleFonts.orbitron(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -2,
    height: 1.0,
    color: GSColors.textPrimary,
  );

  static TextStyle score = GoogleFonts.orbitron(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 1.1,
    color: GSColors.textPrimary,
  );
}
