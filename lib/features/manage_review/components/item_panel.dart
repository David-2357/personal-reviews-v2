import 'package:personal_reviews/features/manage_review/components/folder_path_selector.dart';
import 'package:personal_reviews/features/manage_review/models/review_form_notifier.dart';
import 'package:personal_reviews/features/manage_review/providers/category_provider.dart';
import 'package:personal_reviews/features/manage_review/providers/folder_provider.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/constants/category_icons.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/data/mappers/folder_mapper.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ItemPanel extends ConsumerStatefulWidget {
  const ItemPanel({super.key});

  @override
  ConsumerState<ItemPanel> createState() => _ItemPanelState();
}

class _ItemPanelState extends ConsumerState<ItemPanel> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(
      text: ref.read(reviewFormProvider).itemName,
    );

    _nameController.addListener(() {
      final notifier = ref.read(reviewFormProvider.notifier);

      if (_nameController.text != ref.read(reviewFormProvider).itemName) {
        notifier.updateItemName(_nameController.text);
      }
    });

    ref.listenManual(reviewFormProvider.select((state) => state.itemName), (
      _,
      next,
    ) {
      if (_nameController.text != next) {
        _nameController.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(reviewFormProvider);
    final allCategories = ref.watch(allCategoriesProvider);
    final rootFolders = ref.watch(foldersProvider);

    final hasFolder = form.folderPath.isNotEmpty;

    final folderPath = hasFolder
        ? form.folderPath.map((folder) => folder.name).join(' / ')
        : 'Sin carpeta';

    return Column(
      spacing: AppSpacing.lg,
      children: [
        Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre corto de lo que quieres reseñar',
              style: context.textTheme.bodyMedium,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Ej: Matilda, Tarta Mercadona, etc.',
              ),
              maxLength: 100,
              onChanged: (ref.read(reviewFormProvider.notifier).updateItemName),
            ),
          ],
        ),

        // Select category (show icon and color)
        Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoría', style: context.textTheme.bodyMedium),
            DropdownButtonFormField<CategoryDomain>(
              initialValue: form.category,

              decoration: InputDecoration(hintText: 'Selecciona una categoría'),

              items: allCategories.when(
                data: (categories) {
                  return categories.map((category) {
                    final categoryIcon = getCategoryIcon(category.icon);
                    return DropdownMenuItem<CategoryDomain>(
                      value: category,
                      child: Row(
                        spacing: AppSpacing.sm,
                        children: [
                          Icon(
                            categoryIcon.icon,
                            color: category.color.toColor(),
                            size: AppSizes.alg,
                          ),
                          Text(category.name),
                        ],
                      ),
                    );
                  }).toList();
                },
                loading: () => [
                  const DropdownMenuItem<CategoryDomain>(
                    value: null,
                    child: Text('Cargando categorías...'),
                  ),
                ],
                error: (error, stack) => [
                  const DropdownMenuItem<CategoryDomain>(
                    value: null,
                    child: Text('Error al cargar categorías'),
                  ),
                ],
              ),

              onChanged: (CategoryDomain? newCategory) {
                if (newCategory != null) {
                  ref
                      .read(reviewFormProvider.notifier)
                      .updateCategory(newCategory);
                }
              },
            ),
          ],
        ),

        Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ubicación de la reseña', style: context.textTheme.bodyMedium),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.nm,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.colors.surfaceContainer,
                border: Border.all(
                  color: context.colors.onSurface.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      folderPath,
                      style: context.textTheme.bodyLarge,
                      softWrap: hasFolder,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.edit_rounded),
                    onPressed: () {
                      rootFolders.whenData(
                        (rootFolders) => showDialog(
                          context: context,
                          builder: (context) {
                            return FolderPathSelector(
                              selectedPath: form.folderPath.isNotEmpty
                                  ? form.folderPath
                                  : null,
                              rootFolders: rootFolders,
                              onFolderSelected: (selectedPath) {
                                ref
                                    .read(reviewFormProvider.notifier)
                                    .updateFolderPath(
                                      FolderWithChildrenMapper.flattenOnlyParentFolders(
                                        selectedPath,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ItemSummary extends ConsumerWidget {
  const ItemSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(reviewFormProvider);

    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        Text(
          form.itemName.isEmpty == true ? 'Sin nombre' : form.itemName,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        Text(
          form.category != null
              ? 'Categoría ${form.category?.name.toLowerCase()}'
              : 'Sin categoría',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),

        Text(
          form.folderPath.isNotEmpty
              ? 'Dentro de ${form.folderPath.map((folder) => folder.name).join(' / ')}'
              : 'Sin carpeta',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
