import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color(0xFFFF424E),
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFFFFDAD9),
  onPrimaryContainer: const Color(0xFF410005),
  secondary: const Color(0xFF775656),
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFFFFDAD9),
  onSecondaryContainer: const Color(0xFF2C1516),
  tertiary: const Color(0xFF755A2F),
  onTertiary: Colors.white,
  tertiaryContainer: const Color(0xFFFFDDB0),
  onTertiaryContainer: const Color(0xFF281800),
  error: const Color(0xFFBA1A1A),
  errorContainer: const Color(0xFFFFDAD6),
  onError: Colors.white,
  onErrorContainer: const Color(0xFF410002),
  background: Colors.white,
  onBackground: const Color(0xFF201A1A),
  surface: Colors.white,
  onSurface: const Color(0xFF201A1A),
  surfaceVariant: const Color(0xFFF4DDDD),
  onSurfaceVariant: const Color(0xFF534344),
  outline: const Color(0xFF857374),
  onInverseSurface: const Color(0xFFFBEEED),
  inverseSurface: const Color(0xFF362F2F),
  inversePrimary: const Color(0xFFFFB3B3),
  shadow: const Color(0xFF000000),
  surfaceTint: const Color(0xFFBF0031),
);

class AppTheme {
  // Text Styles
  static TextStyle get heading1 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get heading2 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get heading3 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get caption => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        height: 1.2,
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
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
}