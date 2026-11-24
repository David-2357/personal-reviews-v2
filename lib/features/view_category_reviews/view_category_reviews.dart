import 'package:personal_reviews/features/folder_explorer/folder_explorer.dart';
import 'package:personal_reviews/shared/components/app_main_floating_buttons.dart';
import 'package:personal_reviews/shared/layouts/secondary_layout.dart';
import 'package:personal_reviews/core/constants/category_icons.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/core/types/elements_filter.dart';
import 'package:personal_reviews/core/types/folder_explorer.dart';
import 'package:personal_reviews/core/types/menu_action.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:flutter/material.dart';

class ViewCategoryReviews extends StatelessWidget {
  const ViewCategoryReviews({super.key, required this.category});

  final CategoryWithStats category;

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: 'Ver categoría',
      scrollable: false,
      actions: _buildMenuActions(category.category.id),
      floatingActionButton: AppMainFloatingButtons(
        category: category.category,
        bottomPadding: true,
      ),
      child: _CategoryElementsList(category: category),
    );
  }
}

List<MenuAction> _buildMenuActions(int categoryId) {
  return [
    MenuAction(
      label: 'Editar categoría',
      icon: Icons.edit_rounded,
      onPressed: () {
        debugPrint('Editar categoría $categoryId');
      },
    ),
    MenuAction(
      label: 'Eliminar categoría',
      icon: Icons.delete_rounded,
      type: MenuActionType.destructive,
      onPressed: () {
        debugPrint('Eliminar categoría $categoryId');
      },
    ),
  ];
}

class _CategoryHeader extends StatelessWidget {
  final CategoryWithStats category;

  const _CategoryHeader({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = category.category.color.toColor();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.md,
      children: [
        Container(
          padding: AppInsets.allSm,
          decoration: BoxDecoration(color: color, borderRadius: AppRadius.md),
          child: Icon(
            presetCategories[category.category.icon]?.icon ??
                Icons.category_outlined,
            color: Colors.white,
            size: AppSizes.lg,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.6,
              ),
              child: Text(
                category.category.name.isNotEmpty
                    ? category.category.name
                    : 'Categoría sin nombre',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${category.itemCount} reseñas',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryElementsList extends StatelessWidget {
  const _CategoryElementsList({required this.category});

  final CategoryWithStats category;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.md,
      children: [
        const SizedBox(height: 0),

        _CategoryHeader(category: category),

        Divider(
          height: 1,
          thickness: 1,
          color: context.colors.onSurfaceVariant.withValues(alpha: 0.3),
        ),

        Expanded(
          child: FolderExplorer(
            config: FolderExplorerConfig(
              showCategoriesFilter: false,
              defaultFilter: ElementsFilter(
                categoryIds: [category.category.id],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
