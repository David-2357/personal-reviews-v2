import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/features/manage_review/components/accordion_header.dart';
import 'package:personal_reviews/features/manage_review/components/review_panel.dart';
import 'package:personal_reviews/features/manage_review/components/item_panel.dart';
import 'package:personal_reviews/features/manage_review/models/review_form_notifier.dart';
import 'package:personal_reviews/features/manage_review/models/review_form.dart';
import 'package:personal_reviews/shared/layouts/secondary_layout.dart';
import 'package:personal_reviews/shared/widgets/app_snackbar.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/review.dart';
import 'package:flutter/material.dart';

class ManageReview extends ConsumerStatefulWidget {
  const ManageReview({
    super.key,
    this.folderPath = const [],
    this.category,
    this.reviewToEdit,
  });

  final ReviewDetailed? reviewToEdit;
  final List<FolderDetailed> folderPath;
  final CategoryDomain? category;

  @override
  ManageReviewState createState() => ManageReviewState();
}

class ManageReviewState extends ConsumerState<ManageReview> {
  set itemName(String value) {}

  set category(CategoryDomain value) {}

  set folderPath(List<FolderDetailed> value) {}

  ReviewForm? saveReviewForm() {
    final form = ref.read(reviewFormProvider);
    final hasItemName = form.itemName.trim().isNotEmpty;
    final hasCategory = form.category != null;

    var fieldsNames = '';

    if (!hasItemName) {
      fieldsNames += 'nombre del objetivo';
    }

    if (!hasCategory) {
      if (fieldsNames.isNotEmpty) fieldsNames += ' y la ';
      fieldsNames += 'categoría';
    }

    if (!hasItemName || !hasCategory) {
      AppSnackbar.showWarning(
        context,
        'Se necesita $fieldsNames antes de guardar la reseña.',
      );
      return null;
    }

    return form;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(reviewFormProvider.notifier);

      if (widget.reviewToEdit != null) {
        notifier.loadFromReview(review: widget.reviewToEdit!);
      } else {
        notifier.reset();

        notifier.updateCategory(widget.category);
        notifier.updateFolderPath(
          widget.folderPath.map((folder) => folder.folder).toList(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: 'Crear reseña',
      scrollable: true,
      child: Column(
        spacing: AppSpacing.xxl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionPanelList.radio(
            elevation: 0,
            initialOpenPanelValue: 'review_panel',
            dividerColor: context.colors.onSurface.withValues(alpha: 0.2),
            expandedHeaderPadding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xs,
            ),

            children: [
              /* Review Panel */
              ExpansionPanelRadio(
                canTapOnHeader: true,
                value: 'review_panel',
                headerBuilder: (context, isExpanded) {
                  return AccordionHeader(
                    title: 'Reseña',
                    isExpanded: isExpanded,
                    summary: ReviewSummary(),
                  );
                },

                body: ReviewPanel(),
              ),

              /* Item Panel */
              ExpansionPanelRadio(
                canTapOnHeader: true,
                value: 'item_panel',
                headerBuilder: (context, isExpanded) {
                  return AccordionHeader(
                    title: 'Objetivo de la reseña',
                    isExpanded: isExpanded,
                    summary: ItemSummary(),
                  );
                },

                body: ItemPanel(),
              ),
            ],
          ),

          /* Save and Reset Buttons */
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: AppSpacing.sm,
            children: [
              Expanded(
                // Reset button
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    overlayColor: context.colors.surface,
                  ),
                  onPressed: () {
                    ref.read(reviewFormProvider.notifier).reset();
                  },
                  label: Text('Resetear'),
                  icon: Icon(Icons.restart_alt_rounded),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    overlayColor: context.colors.surface,
                  ),
                  onPressed: () {
                    final form = saveReviewForm();
                    if (form == null) return;

                    // TODO: Llamar a la base de datos con `form`.
                  },
                  label: Text('Guardar'),
                  icon: Icon(Icons.save_rounded),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.listBottomSpacing),
        ],
      ),
    );
  }
}
