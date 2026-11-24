import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const xsm = 6.0;
  static const sm = 8.0;
  static const nm = 12.0;
  static const md = 16.0;
  static const alg = 20.0;
  static const lg = 24.0;
  static const axl = 28.0;
  static const xl = 32.0;
  static const xxl = 40.0;

  static const messageTopSpacing = 60.0;
  static const listBottomSpacing = 60.0;
}

abstract final class AppInsets {
  static const allXxs = EdgeInsets.all(AppSpacing.xxs);
  static const allXs = EdgeInsets.all(AppSpacing.xs);
  static const allSm = EdgeInsets.all(AppSpacing.sm);
  static const allMd = EdgeInsets.all(AppSpacing.md);
  static const allLg = EdgeInsets.all(AppSpacing.lg);
  static const allXl = EdgeInsets.all(AppSpacing.xl);

  // This is used for the padding of the page
  static const pageInsets = EdgeInsets.fromLTRB(26, 26, 26, 0);

  static const dialogContent = EdgeInsets.fromLTRB(
    AppSpacing.lg,
    AppSpacing.lg,
    AppSpacing.lg,
    AppSpacing.lg - AppSpacing.xs,
  );
}
