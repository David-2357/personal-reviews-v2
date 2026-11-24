import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/constants/category_icons.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/core/types/elements_filter.dart';
import 'package:personal_reviews/core/types/folder_explorer.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:flutter/material.dart';

class ElementsFilterSheet extends StatefulWidget {
  const ElementsFilterSheet({
    super.key,
    required this.allCategories,
    required this.currentFilter,
    required this.onFilterApplied,
    required this.config,
  });

  final List<CategoryDomain> allCategories;
  final ElementsFilter currentFilter;
  final FolderExplorerConfig config;

  final ValueChanged<ElementsFilter> onFilterApplied;

  @override
  State<ElementsFilterSheet> createState() => ElementsFilterSheetState();
}

class ElementsFilterSheetState extends State<ElementsFilterSheet> {
  late ElementsVisibility _selectedVisibility;
  late double _minRating;
  late double _maxRating;
  late List<int> _selectedCategoryIds;

  @override
  void initState() {
    super.initState();
    _selectedVisibility = widget.currentFilter.visibility;
    _minRating = widget.currentFilter.minRating;
    _maxRating = widget.currentFilter.maxRating;
    _selectedCategoryIds = [...widget.currentFilter.categoryIds];
  }

  void resetFilter() {
    setState(() {
      _selectedVisibility = widget.config.defaultFilter.visibility;
      _minRating = widget.config.defaultFilter.minRating;
      _maxRating = widget.config.defaultFilter.maxRating;
      _selectedCategoryIds = [...widget.config.defaultFilter.categoryIds];
    });
  }

  void applyFilter() {
    widget.onFilterApplied(
      ElementsFilter(
        visibility: _selectedVisibility,
        minRating: _minRating,
        maxRating: _maxRating,
        categoryIds: _selectedCategoryIds,
      ),
    );
    Navigator.pop(context);
  }

  void _onVisibilitySelected(ElementsVisibility visibility) {
    setState(() {
      _selectedVisibility = visibility;
    });
  }

  CategoryDomain? _getCategoryById(int categoryId) {
    debugPrint('Getting category name for id: $categoryId');
    if (widget.allCategories.isEmpty) {
      debugPrint('All categories list is empty');
      return null;
    }

    final category = widget.allCategories.firstWhere(
      (category) => category.id == categoryId,
    );
    return category;
  }

  @override
  Widget build(BuildContext context) {
    final bool showCategoryInfoText =
        !widget.config.showCategoriesFilter &&
        widget.config.defaultFilter.categoryIds.isNotEmpty &&
        _getCategoryById(widget.config.defaultFilter.categoryIds.first) != null;

    return SafeArea(
      child: Padding(
        padding: AppInsets.allLg.copyWith(top: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.nm,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: AppSpacing.lg,
              children: [
                Text(
                  'Filtrar',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),

                if (!widget.config.groupByFolders)
                  const InfoText(
                    label: 'Sin agrupar',
                    icon: Icons.folder_off_rounded,
                  )
                else if (showCategoryInfoText)
                  CategoryInfoText(
                    category: _getCategoryById(
                      widget.config.defaultFilter.categoryIds.first,
                    )!,
                  ),
                // Close button
                const Spacer(),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),

            // Visibility
            if (widget.config.showVisibilityFilter &&
                widget.config.groupByFolders) ...[
              _VisibilityFilter(
                selectedVisibility: _selectedVisibility,
                onVisibilitySelected: _onVisibilitySelected,
              ),

              const SizedBox(height: 0),
            ],

            // Categories
            if (widget.config.showCategoriesFilter) ...[
              _CategoryFilter(
                allCategories: widget.allCategories,
                selectedCategoryIds: _selectedCategoryIds,
                onCategorySelected: (categoryId) {
                  setState(() {
                    if (!_selectedCategoryIds.contains(categoryId)) {
                      _selectedCategoryIds.add(categoryId);
                    }
                  });
                },
                onCategoryDeselected: (categoryId) {
                  setState(() {
                    _selectedCategoryIds.remove(categoryId);
                  });
                },

                removeAllCategories: () {
                  setState(() {
                    _selectedCategoryIds.clear();
                  });
                },
              ),
              const SizedBox(height: 0),
            ],

            // Rating
            _RatingFilter(
              minRating: _minRating,
              maxRating: _maxRating,
              onRatingChanged: (RangeValues values) {
                setState(() {
                  _minRating = values.start;
                  _maxRating = values.end;
                });
              },
              config: widget.config,
            ),

            const SizedBox(height: 0),

            Row(
              spacing: AppSpacing.sm,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      resetFilter();
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('Resetear'),
                  ),
                ),

                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => applyFilter(),
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Aplicar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.context,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  final BuildContext context;
  final String label;
  final IconData icon;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      onSelected: (value) {
        FocusManager.instance.primaryFocus?.unfocus();

        onSelected(value);
      },
      avatar: Icon(
        icon,
        size: AppSizes.chipIconSize,
        color: selected ? context.colors.onSecondary : context.colors.onSurface,
      ),
      label: Text(label),
    );
  }
}

// WIdget for visibility filter
class _VisibilityFilter extends StatelessWidget {
  const _VisibilityFilter({
    required this.selectedVisibility,
    required this.onVisibilitySelected,
  });

  final ElementsVisibility selectedVisibility;
  final ValueChanged<ElementsVisibility> onVisibilitySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text('Visibilidad', style: context.textTheme.titleSmall),

        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xxs,
          children: [
            ChoiceChip(
              selected: selectedVisibility == ElementsVisibility.all,
              onSelected: (_) => onVisibilitySelected(ElementsVisibility.all),
              label: const Text('Todo'),
            ),
            _FilterChip(
              context: context,
              label: ElementsVisibility.foldersOnly.label,
              icon: Icons.folder_rounded,
              selected: selectedVisibility == ElementsVisibility.foldersOnly,
              onSelected: (_) =>
                  onVisibilitySelected(ElementsVisibility.foldersOnly),
            ),
            _FilterChip(
              context: context,
              label: ElementsVisibility.itemsOnly.label,
              icon: Icons.star_rounded,
              selected: selectedVisibility == ElementsVisibility.itemsOnly,
              onSelected: (_) =>
                  onVisibilitySelected(ElementsVisibility.itemsOnly),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget for rating filter
class _RatingFilter extends StatelessWidget {
  const _RatingFilter({
    required this.minRating,
    required this.maxRating,
    required this.onRatingChanged,
    required this.config,
  });

  final double minRating;
  final double maxRating;
  final ValueChanged<RangeValues> onRatingChanged;
  final FolderExplorerConfig config;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          'Puntuación  ($minRating - $maxRating ★)',
          style: context.textTheme.titleSmall,
        ),

        RangeSlider(
          values: RangeValues(minRating.toDouble(), maxRating.toDouble()),
          min: 0,
          max: 5,
          divisions: 10,
          labels: RangeLabels(minRating.toString(), maxRating.toString()),
          onChanged: (RangeValues values) {
            onRatingChanged(values);
          },
        ),
      ],
    );
  }
}

// Widget for category filter
class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({
    required this.allCategories,
    required this.selectedCategoryIds,
    required this.onCategorySelected,
    required this.onCategoryDeselected,
    required this.removeAllCategories,
  });

  final List<CategoryDomain> allCategories;
  final List<int> selectedCategoryIds;
  final ValueChanged<int> onCategorySelected;
  final ValueChanged<int> onCategoryDeselected;
  final VoidCallback removeAllCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.xs,
      children: [
        Text(
          'Categorías ${selectedCategoryIds.isNotEmpty ? "(${selectedCategoryIds.length})" : ""}',
          style: context.textTheme.titleSmall,
        ),

        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Row(
                  spacing: AppSpacing.sm,
                  children: [
                    ChoiceChip(
                      label: const Text('Todas'),
                      selectedColor: context.colors.secondaryContainer,
                      selected: selectedCategoryIds.isEmpty,
                      onSelected: (isSelected) => removeAllCategories(),
                    ),
                    for (var category in allCategories)
                      _CategoryFilterChip(
                        category: category,
                        // search id
                        selected: selectedCategoryIds.contains(category.id),

                        onSelected: (isSelected) => isSelected
                            ? onCategorySelected(category.id)
                            : onCategoryDeselected(category.id),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CategoryFilterChip extends StatelessWidget {
  const _CategoryFilterChip({
    required this.category,
    required this.selected,
    required this.onSelected,
  });

  final CategoryDomain category;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      onSelected: (value) {
        FocusManager.instance.primaryFocus?.unfocus();

        onSelected(value);
      },
      avatar: Icon(
        getCategoryIconData(category.icon),
        size: AppSizes.chipIconSize,
        color: Colors.white,
      ),
      label: Text(category.name),
      selectedColor: category.color.toColor().withValues(alpha: 0.6),
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        Icon(
          icon,
          size: AppSizes.chipIconSize,
          color: context.colors.onSurfaceVariant,
        ),
        Flexible(
          child: Text(
            textDirection: TextDirection.rtl,
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class CategoryInfoText extends StatelessWidget {
  const CategoryInfoText({super.key, required this.category});

  final CategoryDomain category;

  @override
  Widget build(BuildContext context) {
    return InfoText(
      label: category.name,
      icon: getCategoryIconData(category.icon),
    );
  }
}
