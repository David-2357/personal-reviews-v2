import 'package:flutter/material.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';

class AccordionHeader extends StatelessWidget {
  const AccordionHeader({
    super.key,
    required this.title,
    required this.summary,
    required this.isExpanded,
  });

  final String title;
  final Widget? summary;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.nm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isExpanded && summary != null) ...[
            const SizedBox(height: AppSpacing.xs),
            summary!,
          ],
        ],
      ),
    );
  }
}
