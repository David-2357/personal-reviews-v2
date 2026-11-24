import 'package:flutter/material.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/shared/widgets/app_dialog.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';

abstract final class AppConfirmationDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? message = '',
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    IconData? icon,
    Color? confirmColor,
    Color? iconColor,
    bool barrierDismissible = false,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: title,
      barrierColor: Colors.black54,
      transitionDuration: AppDialogTransition.duration,
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return SafeArea(
          child: Center(
            child: AppDialogSurface(
              backgroundColor: dialogContext.colors.surfaceContainer,
              child: _ConfirmationDialogContent(
                title: title,
                message: message ?? '',
                confirmText: confirmText,
                cancelText: cancelText,
                icon: icon,
                confirmColor: confirmColor,
                iconColor: iconColor,
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return AppDialogTransition.build(animation, child);
      },
    );
  }
}

class _ConfirmationDialogContent extends StatelessWidget {
  const _ConfirmationDialogContent({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.icon,
    this.confirmColor,
    this.iconColor,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final IconData? icon;
  final Color? confirmColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.dialogContent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 42,
              color:
                  iconColor ??
                  (confirmColor ?? context.colors.primaryContainer),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),

          if (message.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: AppSpacing.md),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurface.withValues(alpha: 0.9),
                    height: 1.45,
                  ),
                ),
              ],
            ),

          const SizedBox(height: AppSpacing.lg),

          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: FilledButton.styleFrom(
              backgroundColor: confirmColor ?? context.colors.primaryContainer,
              foregroundColor: context.colors.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
            ),
            child: Text(confirmText),
          ),

          const SizedBox(height: AppSpacing.xxs),

          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colors.onSurface,
              side: BorderSide(color: context.colors.onSurfaceVariant),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
            ),
            child: Text(cancelText),
          ),
        ],
      ),
    );
  }
}
