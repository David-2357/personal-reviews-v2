import 'package:flutter/material.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/features/manage_review/manage_review.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/domain/models/folder.dart';

// TODO: Move this to core folder
enum DominantHand { left, right }

class AppMainFloatingButtons extends StatelessWidget {
  const AppMainFloatingButtons({
    super.key,
    this.dominantHand = DominantHand.right,
    this.folderPath = const [],
    this.category,
    this.bottomPadding = false,
  });

  final DominantHand dominantHand;
  final List<FolderDetailed> folderPath;
  final CategoryDomain? category;
  final bool bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: dominantHand == DominantHand.right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      spacing: AppSpacing.nm,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton.small(
            heroTag: 'createFolderFab',

            backgroundColor: context.colors.surfaceContainerHighest,
            foregroundColor: context.colors.onSurfaceVariant,

            onPressed: () {
              // TODO: Implement create folder functionality
            },
            child: const Icon(Icons.create_new_folder, size: AppSizes.alg),
          ),
        ),

        FloatingActionButton(
          heroTag: 'createReviewFab',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ManageReview(
                  folderPath: folderPath,
                  category: category,
                  reviewToEdit: null,
                ),
              ),
            );
          },
          child: const Icon(Icons.star_rounded, size: AppSizes.axl),
        ),

        if (bottomPadding) SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
