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
  bool _isSaving = false;
  bool _allowPop = false;
  bool _isShowingDiscardDialog = false;
  bool isEditing = false;
  bool isAddingReviewToItem = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final notifier = ref.read(reviewFormProvider.notifier);

      if (widget.reviewToEdit != null) {
        setState(() {
          if (widget.reviewToEdit?.reviewId != 0) {
            isEditing = true;
            isAddingReviewToItem = false;
          } else {
            isAddingReviewToItem = true;
            isEditing = false;
          }
        });

        notifier.loadFromForm(form: widget.reviewToEdit!);
        return;
      }

      isEditing = false;
      isAddingReviewToItem = false;

      notifier
        ..reset()
        ..updateCategory(widget.category?.id, widget.category?.name)
        ..updateFolderPath(
          widget.folderPath.map((folder) => folder.folder).toList(),
        );
    });
  }

  ReviewForm? _validateForm() {
    final notifier = ref.read(reviewFormProvider.notifier);
    final errors = notifier.validate();

    if (errors.isNotEmpty) {
      AppSnackbar.showWarning(
        context,
        'Se necesita ${errors.join(' y ')} antes de guardar la reseña.',
      );
      return null;
    }

    return ref.read(reviewFormProvider);
  }

  Future<void> _handleSaveError(Object error, StackTrace stackTrace) async {
    await AppCriticErrorDialog.show(
      context,
      ErrorTypePresenter.of(ErrorType.database),
      'Ocurrió un error al guardar la reseña. Por favor, inténtalo de nuevo.',
      onRetry: () async {
        await _save();
      },
    );
  }

  Future<void> _save() async {
    if (_isSaving || !mounted) return;

    final form = _validateForm();

    if (form == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final repository = ref.read(itemReviewProvider);

      await repository.createOrUpdateReview(form);

      if (!mounted) return;

      goBackAfterSave();
    } catch (error, stackTrace) {
      if (!mounted) return;

      await _handleSaveError(error, stackTrace);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void goBackAfterSave() {
    if (!mounted || !Navigator.canPop(context)) return;

    ref.read(reviewFormProvider.notifier).reset();

    Navigator.pop(context);

    AppSnackbar.showSuccess(context, 'Reseña guardada exitosamente');
  }

  void goBackWithoutSaving() {
    if (!mounted || !Navigator.canPop(context)) return;

    ref.read(reviewFormProvider.notifier).reset();

    Navigator.pop(context);
  }

  Future<void> onResetPressed() async {
    final reviewFormNotifier = ref.read(reviewFormProvider.notifier);

    if (reviewFormNotifier.hasChanges()) {
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

  Future<void> _confirmDiscardChanges() async {
    if (!mounted || _isSaving || _isShowingDiscardDialog || _allowPop) {
      return;
    }

    final hasChanges = ref.read(reviewFormProvider.notifier).hasChanges();

    if (!hasChanges) return;

    _isShowingDiscardDialog = true;

    bool? confirmed;

    try {
      confirmed = await AppConfirmationDialog.show(
        context,
        title: '¿Quieres descartar los cambios?',
        confirmText: 'Descartar',
        cancelText: 'Seguir editando',
        icon: Icons.warning_amber,
        confirmColor: AppColors.warningContainer,
      );
    } finally {
      _isShowingDiscardDialog = false;
    }

    if (!mounted || confirmed != true) return;

    setState(() {
      _allowPop = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  String get _appBarTitle {
    if (isEditing) {
      return 'Editar Reseña';
    } else if (isAddingReviewToItem) {
      return 'Agregar Reseña';
    } else {
      return 'Nueva Reseña';
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(reviewFormProvider);

    return PopScope(
      canPop:
          (!_isSaving && !ref.read(reviewFormProvider.notifier).hasChanges()) ||
          _allowPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        await _confirmDiscardChanges();
      },
      child: SecondaryLayout(
        title: _appBarTitle,
        scrollable: true,
        child: Column(
          spacing: AppSpacing.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // If its editing a review, show an alert
            if (isEditing || isAddingReviewToItem)
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
                        isAddingReviewToItem
                            ? 'Estás agregando una reseña a "${widget.reviewToEdit?.itemName}".'
                            : 'Estás editando la reseña de "${widget.reviewToEdit?.itemName}".',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!isAddingReviewToItem)
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
                        isExpanded: isExpanded || isAddingReviewToItem,
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

            if (isAddingReviewToItem) const SizedBox(height: AppSpacing.sm),
            if (isAddingReviewToItem) ReviewPanel(),
            if (isAddingReviewToItem) const SizedBox(height: AppSpacing.sm),

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
                      backgroundColor: _isSaving
                          ? context.colors.primaryContainer.withValues(
                              alpha: 0.5,
                            )
                          : context.colors.primaryContainer,
                    ),
                    onPressed: () {
                      _save();
                    },
                    label: _isSaving
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
