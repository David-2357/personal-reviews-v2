import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';

import 'app_colors.dart';
import 'app_button_theme.dart';
import 'app_input_theme.dart';
//import 'app_text_theme.dart';

final colorScheme = ColorScheme.dark(
  brightness: Brightness.dark,

  surface: AppColors.surface,
  surfaceContainer: AppColors.surfaceContainer,
  surfaceContainerLow: AppColors.surfaceContainerLow,
  surfaceContainerHigh: AppColors.surfaceContainerHigh,
  surfaceContainerHighest: AppColors.surfaceContainerHighest,

  primary: AppColors.primary,
  secondary: AppColors.secondary,
  tertiary: AppColors.tertiary,

  error: AppColors.error,

  primaryContainer: AppColors.primaryContainer,
  secondaryContainer: AppColors.secondaryContainer,

  onSurface: AppColors.onSurface,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  onPrimary: AppColors.onPrimary,
  onSecondary: AppColors.onSecondary,
  onTertiary: AppColors.onTertiary,

  outline: AppColors.surfaceContainerHighest,
);

final appTheme = ThemeData(
  useMaterial3: true,

  fontFamily: GoogleFonts.inter().fontFamily,

  colorScheme: colorScheme,

  scaffoldBackgroundColor: AppColors.surface,

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onSurface,
    elevation: 0,
  ),

  /* Input */
  inputDecorationTheme: appInputDecorationTheme,

  searchBarTheme: appSearchBarTheme,
  dropdownMenuTheme: appDropdownMenuTheme,

  /* Chips */
  chipTheme: ChipThemeData(
    side: WidgetStateBorderSide.resolveWith((states) {
      return BorderSide(
        color: states.contains(WidgetState.selected)
            ? colorScheme.secondaryContainer
            : colorScheme.outline,
      );
    }),
    backgroundColor: Colors.transparent,
    selectedColor: colorScheme.secondaryContainer,
    showCheckmark: false,
  ),

  /* Buttons */
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.primary(colorScheme),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: AppButtonStyles.primary(colorScheme),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: AppButtonStyles.outlined(colorScheme),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(colorScheme.primary),
      padding: AppButtonStyles.padding,
      shape: AppButtonStyles.shape,
    ),
  ),

  segmentedButtonTheme: SegmentedButtonThemeData(
    style: AppButtonStyles.segmented(colorScheme),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: colorScheme.primaryContainer,
    foregroundColor: colorScheme.onPrimary,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
  ),

  /* Range */
  sliderTheme: SliderThemeData(
    activeTrackColor: colorScheme.secondary.withValues(alpha: 0.8),
    inactiveTrackColor: colorScheme.onSurface.withValues(alpha: 0.3),
    thumbColor: colorScheme.secondary,
    trackHeight: 5,
    overlayColor: colorScheme.secondary.withValues(alpha: 0.2),

    activeTickMarkColor: colorScheme.secondary.withValues(green: 0.6),
    inactiveTickMarkColor: colorScheme.onSurface.withValues(alpha: 0.5),

    valueIndicatorTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
    valueIndicatorColor: colorScheme.surface,
  ),
);
