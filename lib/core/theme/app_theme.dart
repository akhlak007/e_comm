import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFF6366F1), // Modern indigo
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFFEEF2FF),
  onPrimaryContainer: const Color(0xFF312E81),
  secondary: const Color(0xFF64748B),
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFFF1F5F9),
  onSecondaryContainer: const Color(0xFF1E293B),
  tertiary: const Color(0xFF0EA5E9),
  onTertiary: Colors.white,
  tertiaryContainer: const Color(0xFFE0F2FE),
  onTertiaryContainer: const Color(0xFF0C4A6E),
  error: const Color(0xFFEF4444),
  errorContainer: const Color(0xFFFEE2E2),
  onError: Colors.white,
  onErrorContainer: const Color(0xFF7F1D1D),
  background: Colors.white,
  onBackground: const Color(0xFF0F172A),
  surface: Colors.white,
  onSurface: const Color(0xFF0F172A),
  surfaceVariant: const Color(0xFFF8FAFC),
  onSurfaceVariant: const Color(0xFF64748B),
  outline: const Color(0xFFCBD5E1),
  shadow: Colors.black.withOpacity(0.1),
  inverseSurface: const Color(0xFF0F172A),
  onInverseSurface: Colors.white,
  inversePrimary: const Color(0xFFA5B4FC),
  surfaceTint: const Color(0xFF6366F1),
);

class AppTheme {
  // Text Styles
  static TextStyle get heading1 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get heading2 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle get heading3 => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.25,
  );

  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle get caption => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.25,
  );

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Elevation
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 400);
}