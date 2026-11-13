import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/features/manage_review/components/photo_picker_field.dart';
import 'package:personal_reviews/features/manage_review/components/rating_input.dart';
import 'package:personal_reviews/features/manage_review/notifiers/review_form_notifier.dart';
import 'package:personal_reviews/shared/components/rating_display.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:flutter/material.dart';

class ReviewPanel extends ConsumerStatefulWidget {
  const ReviewPanel({super.key});

  @override
  ConsumerState<ReviewPanel> createState() => _ReviewPanelState();
}

class _ReviewPanelState extends ConsumerState<ReviewPanel> {
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();

    _commentController = TextEditingController(
      text: ref.read(reviewFormProvider).comment,
    );

    _commentController.addListener(() {
      final notifier = ref.read(reviewFormProvider.notifier);

      if (_commentController.text != ref.read(reviewFormProvider).comment) {
        notifier.updateComment(_commentController.text);
      }
    });

    ref.listenManual(reviewFormProvider.select((state) => state.comment), (
      _,
      next,
    ) {
      if (_commentController.text != next) {
        _commentController.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(reviewFormProvider);

    return Column(
      spacing: AppSpacing.lg,
      children: [
        RatingInput(
          value: form.rating,
          onChanged: (value) =>
              ref.read(reviewFormProvider.notifier).updateRating(value),
        ),

        Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escribe un comentario que no quieras olvidar',
              style: context.textTheme.bodyMedium,
            ),
            TextField(
              decoration: InputDecoration(
                hintText:
                    'Ej: Esta muy barata, a solo 2€, el sabor es muy intenso y se nota que es de calidad',
              ),
              maxLength: 1000,
              maxLines: 4,
              onChanged: (value) =>
                  ref.read(reviewFormProvider.notifier).updateComment(value),
              controller: _commentController,
            ),
          ],
        ),

        PhotoPickerField(
          imagePaths: form.imagePaths,
          onImageAdded: (imagePath) {
            ref.read(reviewFormProvider.notifier).addNewImage(imagePath);
          },
          onImageRemoved: (imagePath) {
            ref.read(reviewFormProvider.notifier).removeImageByPath(imagePath);
          },
        ),
      ],
    );
  }
}

class ReviewSummary extends ConsumerWidget {
  const ReviewSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(reviewFormProvider);

    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(height: AppSpacing.xs),
        RatingDisplay(
          rating: form.rating,
          size: 20,
          emptyColor: context.colors.surfaceContainerHighest,
        ),
        Text(
          form.comment.isEmpty == true ? 'Sin comentario' : form.comment,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          form.imagePaths.isNotEmpty == true
              ? '${form.imagePaths.length} fotos'
              : 'Sin fotos',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
