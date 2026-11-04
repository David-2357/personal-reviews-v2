import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/style/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppSnackbar {
  static const Duration _duration = Duration(seconds: 3);
  static const AnimationStyle _animationStyle = AnimationStyle(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 500),
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );

  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline,
    );
  }

  static void showWarning(BuildContext context, String message) {
    _show(
      context,
      message,
      backgroundColor: AppColors.warningContainer,
      icon: Icons.warning_amber,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle_outline,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    IconData? icon,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Elimina los SnackBars pendientes.
    scaffoldMessenger.clearSnackBars();

    // Cierra el SnackBar actual.
    scaffoldMessenger.hideCurrentSnackBar();

    // Muestra el nuevo SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _AnimatedSnackbarContent(message: message, icon: icon),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        duration: _duration,
        showCloseIcon: true,
        closeIconColor: Colors.white,
      ),
      snackBarAnimationStyle: _animationStyle,
    );
  }
}

class _AnimatedSnackbarContent extends StatelessWidget {
  const _AnimatedSnackbarContent({required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
