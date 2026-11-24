import 'package:personal_reviews/features/folder_explorer/providers/categories_provider.dart';
import 'package:personal_reviews/features/folder_explorer/components/filter_sheet.dart';
import 'package:personal_reviews/features/folder_explorer/components/sort_sheet.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/core/types/folder_explorer.dart';
import 'package:personal_reviews/core/types/elements_filter.dart';
import 'package:personal_reviews/core/types/elements_sort.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/core/types/sort.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ElementsControls extends ConsumerStatefulWidget {
  const ElementsControls({
    super.key,
    required this.config,
    required this.elementsFilter,
    required this.elementsSort,
    required this.onSearchChanged,
    required this.onSortApplied,
    required this.onFilterApplied,
    this.isEnabled = true,
  });

  final FolderExplorerConfig config;

  final ElementsFilter elementsFilter;
  final ElementsSort elementsSort;

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ElementsSort> onSortApplied;
  final ValueChanged<ElementsFilter> onFilterApplied;

  final bool isEnabled;

  @override
  ConsumerState<ElementsControls> createState() => _ElementsControlsState();
}

class _ElementsControlsState extends ConsumerState<ElementsControls> {
  bool _isFilterActive(ElementsFilter filter) {
    if (!widget.config.showCategoriesFilter &&
        filter.categoryIds.isNotEmpty &&
        filter.numberOfActiveFilters == 1) {
      return false;
    }

    return filter.isActive;
  }

  Timer? _searchDebounce;

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        widget.onSearchChanged(value);
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void onSortPressed() {
    FocusManager.instance.primaryFocus?.unfocus();

    _showSortSheet(
      context,
      widget.elementsSort,
      widget.config.defaultSort,
      widget.onSortApplied,
    );
  }

  void onFilterPressed(List<CategoryDomain> categories) {
    FocusManager.instance.primaryFocus?.unfocus();

    _showFilterSheet(
      context,
      widget.elementsFilter,
      widget.onFilterApplied,
      widget.config,
      categories,
    );
  }

  void onResetFiltersPressed() {
    widget.onFilterApplied(widget.config.defaultFilter);
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        ref.watch(categoriesProvider).value ?? const <CategoryDomain>[];

    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpacing.sm,
              children: [
                // Search bar
                if (widget.config.showSearch)
                  Expanded(
                    child: SearchBar(
                      leading: Icon(
                        Icons.search_rounded,
                        size: 23,
                        color: context.colors.onSurfaceVariant,
                      ),
                      hintText: 'Buscar...',
                      onChanged: _onSearchChanged,
                    ),
                  ),

                // Sort button
                if (widget.config.showSort)
                  AspectRatio(
                    aspectRatio: 1,
                    child: _SortButton(
                      sort: widget.elementsSort,
                      onPressed: onSortPressed,
                      isActive: !widget.elementsSort.compare(
                        widget.config.defaultSort,
                      ),
                    ),
                  ),

                // Filter button
                if (widget.config.showFilter)
                  AspectRatio(
                    aspectRatio: 1,
                    child: _FilterButton(
                      filter: widget.elementsFilter,
                      onPressed: () => onFilterPressed(categories),
                      isActive: _isFilterActive(widget.elementsFilter),
                    ),
                  ),
              ],
            ),
          ),

          // Active filters list
          if (widget.config.showFilter &&
              _isFilterActive(widget.elementsFilter))
            _ActiveFiltersList(
              allCategories: categories,
              filter: widget.elementsFilter,
              showCategoriesFilter: widget.config.showCategoriesFilter,
              onResetFiltersPressed: onResetFiltersPressed,
              onFilterPressed: () => onFilterPressed(categories),
              config: widget.config,
            ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final ElementsSort sort;
  final VoidCallback onPressed;
  final bool isActive;

  const _SortButton({
    required this.sort,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        size: AppSizes.lg,
        !isActive
            ? Icons.sort_rounded
            : (sort.type == SortType.ASC
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded),
      ),

      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(
          isActive
              ? context.colors.secondaryContainer
              : context.colors.surfaceContainer,
        ),
        foregroundColor: WidgetStatePropertyAll(
          isActive
              ? context.colors.onSecondary
              : context.colors.onSurfaceVariant,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.md),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final ElementsFilter filter;
  final VoidCallback onPressed;
  final bool isActive;

  const _FilterButton({
    required this.filter,
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isActive ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,
        size: AppSizes.lg,
      ),

      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(
          isActive
              ? context.colors.secondaryContainer
              : context.colors.surfaceContainer,
        ),
        foregroundColor: WidgetStatePropertyAll(
          isActive
              ? context.colors.onSecondary
              : context.colors.onSurfaceVariant,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.md),
        ),
      ),
    );
  }
}

class _ActiveFiltersList extends StatelessWidget {
  const _ActiveFiltersList({
    required this.allCategories,
    this.showCategoriesFilter = true,
    required this.filter,
    required this.onResetFiltersPressed,
    required this.onFilterPressed,
    required this.config,
  });

  final List<CategoryDomain> allCategories;
  final bool showCategoriesFilter;
  final ElementsFilter filter;
  final FolderExplorerConfig config;
  final VoidCallback onResetFiltersPressed;
  final VoidCallback onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: Row(
              spacing: AppSpacing.sm,
              children: [
                IconButton(
                  onPressed: onResetFiltersPressed,
                  icon: Icon(Icons.close_rounded, size: AppSizes.md),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      context.colors.surfaceContainerLow,
                    ),
                  ),
                ),

                if (filter.isVisibilityActive())
                  _FilterChip(
                    label: filter.visibility.label,
                    onTap: onFilterPressed,
                  ),

                if (filter.isRatingActive())
                  _FilterChip(
                    label: '${filter.minRating} - ${filter.maxRating} ★',
                    onTap: onFilterPressed,
                  ),

                if (showCategoriesFilter &&
                    filter.isCategoriesActive() &&
                    allCategories.isNotEmpty)
                  for (var category in allCategories.where(
                    (c) => filter.categoryIds.contains(c.id),
                  ))
                    _FilterChip(label: category.name, onTap: onFilterPressed),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: context.colors.tertiaryContainer,
      labelStyle: TextStyle(color: context.colors.onTertiary),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.md,
        side: BorderSide(width: 0),
      ),
    );
  }
}

/* Show sort and filter sheets */
Future<void> _showSortSheet(
  BuildContext context,
  ElementsSort currentSort,
  ElementsSort defaultSort,
  void Function(ElementsSort newSort) onSortApplied,
) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return ElementsSortSheet(
        currentSort: currentSort,
        defaultSort: defaultSort,
        onSortApplied: onSortApplied,
      );
    },
  );
}

Future<void> _showFilterSheet(
  BuildContext context,
  ElementsFilter currentFilter,
  void Function(ElementsFilter newFilter) onFilterApplied,
  FolderExplorerConfig config,
  List<CategoryDomain> categories,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return ElementsFilterSheet(
        allCategories: categories,
        currentFilter: currentFilter,
        onFilterApplied: onFilterApplied,
        config: config,
      );
    },
  );
}
