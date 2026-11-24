import 'package:flutter/material.dart';

abstract final class AppColors {
  static const surface = Color(0xFF181D24); // background
  static const surfaceContainer = Color(
    0xFF242C38,
  ); // inputs/cards prev: 20262F
  static const surfaceContainerLow = Color(0xFF1C2129); // disabled elements
  static const surfaceContainerHigh = Color(0xFF20262F); // dialogs
  static const surfaceContainerHighest = Color(
    0xFF393E46,
  ); // empty star in rating display

  static const primary = Color(0xFF00ADB5);
  static const secondary = Color(0xFF087C57);
  static const tertiary = Color(0xFF0051A1);

  // Container for backgrounds
  static const primaryContainer = Color(0xFF167277);
  static const secondaryContainer = Color(0xFF035A3F);
  static const tertiaryContainer = Color(0xFF03498F);

  static const success = Color(0xFF16A34A);
  static const error = Color(0xFFDC2626);
  static const warning = Color(0xFFF59E0B);

  static const warningContainer = Color(0xFF996100);

  static const onSurface = Color(0xFFE5E7EB);
  static const onSurfaceVariant = Color(0xFF9CA3AF);

  static const onPrimary = onSurface;
  static const onSecondary = onSurface;
  static const onTertiary = onSurface;
}
