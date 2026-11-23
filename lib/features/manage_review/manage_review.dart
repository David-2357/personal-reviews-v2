import 'package:personal_reviews/features/manage_review/providers/item_review_provider.dart';
import 'package:personal_reviews/features/manage_review/components/accordion_header.dart';
import 'package:personal_reviews/features/manage_review/notifiers/review_form_notifier.dart';
import 'package:personal_reviews/features/manage_review/components/review_panel.dart';
import 'package:personal_reviews/features/manage_review/components/item_panel.dart';
import 'package:personal_reviews/shared/components/app_confirmation_dialog.dart';
import 'package:personal_reviews/shared/components/app_critic_error_dialog.dart';
import 'package:personal_reviews/shared/errors/error_type_presenter.dart';
import 'package:personal_reviews/shared/layouts/secondary_layout.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/shared/widgets/app_snackbar.dart';
import 'package:personal_reviews/shared/errors/error_type.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/review.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:personal_reviews/style/theme/app_colors.dart';

class ManageReview extends ConsumerStatefulWidget {
  const ManageReview({
    super.key,
    this.folderPath = const [],
    this.category,
    this.reviewToEdit,
  });

  final ReviewForm? reviewToEdit;
  final List<FolderDetailed> folderPath;
  final CategoryDomain? category;

  @override
  ManageReviewState createState() => ManageReviewState();
}

class ManageReviewState extends ConsumerState<ManageReview> {
  bool isSaving = false;
  bool _allowPop = false;
  bool _isShowingDiscardDialog = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(reviewFormProvider.notifier);

      if (widget.reviewToEdit != null) {
        notifier.loadFromForm(form: widget.reviewToEdit!);
        isEditing = true;
      } else {
        isEditing = false;
        notifier.reset();
        notifier.updateCategory(
          widget.category?.id ?? 0,
          widget.category?.name ?? '',
        );
        notifier.updateFolderPath(
          widget.folderPath.map((folder) => folder.folder).toList(),
        );
      }
    });
  }

  ReviewForm? saveReviewForm() {
    final form = ref.read(reviewFormProvider);
    final hasItemName = form.itemName.trim().isNotEmpty;
    final hasCategory = form.categoryId != null && form.categoryId! > 0;

    var fieldsNames = '';

    if (!hasItemName) {
      fieldsNames += 'el nombre del objetivo';
    }

    if (!hasCategory) {
      if (fieldsNames.isNotEmpty) fieldsNames += ' y ';
      fieldsNames += 'la categoría';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemReviewRepository = ref.watch(itemReviewProvider);
    ref.watch(reviewFormProvider);

    final reviewFormNotifier = ref.read(reviewFormProvider.notifier);
    final hasChanges =
        (isEditing && reviewFormNotifier.hasChanges(widget.reviewToEdit!) ||
        !isEditing && !reviewFormNotifier.isEmpty());

    Future<void> goBackAfterSave() async {
      if (!mounted || !Navigator.canPop(context)) return;

      debugPrint(
        'Reseña guardada exitosamente. Regresando a la pantalla anterior...',
      );

      // Resetear el formulario mientras ref todavía es válido.
      ref.read(reviewFormProvider.notifier).reset();

      Navigator.pop(context);

      // Mostrar el SnackBar despues de abandonar la pantalla.
      AppSnackbar.showSuccess(context, 'Reseña guardada exitosamente');
    }

    Future<void> save() async {
      if (isSaving || !mounted) return;

      final form = saveReviewForm();

      if (form == null || !mounted) return;

      setState(() {
        isSaving = true;
      });

      try {
        await itemReviewRepository.createOrUpdateReview(form);

        if (!mounted) return;

        await goBackAfterSave();
      } catch (e) {
        if (!mounted) return;

        AppCriticErrorDialog.show(
          context,
          ErrorTypePresenter.of(ErrorType.database),
          //'Ocurrió un error al guardar la reseña. Por favor, inténtalo de nuevo.',
          e.toString(),
          onRetry: () async {
            await save();
          },
        );
      } finally {
        if (mounted) {
          setState(() {
            isSaving = false;
          });
        }
      }
    }

    Future<void> onResetPressed() async {
      debugPrint(
        isEditing
            ? 'Checking for changes in the form compared to the review being edited...'
            : 'Checking if the form has any changes...',
      );

      if (hasChanges) {
        AppConfirmationDialog.show(
          context,
          title: isEditing
              ? '¿Volver con los cambios de la reseña original?'
              : '¿Volver a la reseña en blanco?',
          confirmText: 'Aceptar',
          cancelText: 'Cancelar',
          icon: Icons.restart_alt_rounded,
        ).then((confirmed) {
          if (confirmed == true) {
            reviewFormNotifier.reset();
          }
        });
      } else {
        reviewFormNotifier.reset();
      }
    }

    return PopScope(
      canPop: (!isSaving && !hasChanges) || _allowPop,
      onPopInvokedWithResult: (didPop, result) async {
        debugPrint(
          'PopScope invoked. canPop: ${!isSaving && !hasChanges}, _allowPop: $_allowPop, didPop: $didPop',
        );

        debugPrint(
          'Is saving: $isSaving, has changes: $hasChanges, allow pop: $_allowPop',
        );

        debugPrint('Review form state: ${ref.read(reviewFormProvider)}');
        if (didPop || _isShowingDiscardDialog) return;

        _isShowingDiscardDialog = true;

        final navigator = Navigator.of(context);

        final confirmed = await AppConfirmationDialog.show(
          context,
          title: '¿Quieres descartar los cambios?',
          confirmText: 'Descartar',
          cancelText: 'Seguir editando',
          icon: Icons.warning_amber,
          confirmColor: AppColors.warningContainer,
        );

        _isShowingDiscardDialog = false;

        if (confirmed != true || !mounted) return;

        setState(() {
          _allowPop = true;
        });

        // Espera a que PopScope actualice canPop.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && navigator.mounted) {
            navigator.pop();
          }
        });
      },
      child: SecondaryLayout(
        title: isEditing ? 'Editar Reseña' : 'Nueva Reseña',
        scrollable: true,
        child: Column(
          spacing: AppSpacing.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If its editing a review, show an alert
            if (isEditing)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: context.colors.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: context.colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Estás editando la reseña de "${widget.reviewToEdit?.itemName}".',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                      onResetPressed();
                    },
                    label: Text('Resetear'),
                    icon: Icon(Icons.restart_alt_rounded),
                  ),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      overlayColor: context.colors.surface,
                      backgroundColor: isSaving
                          ? context.colors.primaryContainer.withValues(
                              alpha: 0.5,
                            )
                          : context.colors.primaryContainer,
                    ),
                    onPressed: () {
                      if (!isSaving) {
                        save();
                      }
                    },
                    label: isSaving
                        ? const Text('Guardando...')
                        : const Text('Guardar'),
                    icon: Icon(Icons.save_rounded),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.listBottomSpacing),
          ],
        ),
      ),
    );
  }
}
