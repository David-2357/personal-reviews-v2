enum ElementsVisibility {
  foldersOnly('Solo carpetas'),
  itemsOnly('Solo reseñas'),
  all('Todo');

  const ElementsVisibility(this.label);

  final String label;
}

class ElementsFilter {
  bool get isActive =>
      isVisibilityActive() || isCategoriesActive() || isRatingActive();

  int get numberOfActiveFilters {
    int count = 0;
    if (isVisibilityActive()) count++;
    if (isCategoriesActive()) count++;
    if (isRatingActive()) count++;
    return count;
  }

  final ElementsVisibility visibility;
  final List<int> categoryIds;
  final double minRating;
  final double maxRating;

  const ElementsFilter({
    this.visibility = ElementsVisibility.all,
    this.categoryIds = const [],
    this.minRating = 0,
    this.maxRating = 5,
  });

  ElementsFilter copyWith({
    ElementsVisibility? visibility,
    List<int>? categoryIds,
    double? minRating,
    double? maxRating,
  }) {
    return ElementsFilter(
      visibility: visibility ?? this.visibility,
      categoryIds: categoryIds ?? this.categoryIds,
      minRating: minRating ?? this.minRating,
      maxRating: maxRating ?? this.maxRating,
    );
  }

  bool compare(ElementsFilter other) {
    return visibility == other.visibility &&
        categoryIds.toSet().containsAll(other.categoryIds) &&
        other.categoryIds.toSet().containsAll(categoryIds) &&
        minRating == other.minRating &&
        maxRating == other.maxRating;
  }

  bool isVisibilityActive() {
    return visibility != ElementsVisibility.all;
  }

  bool isRatingActive() {
    return minRating > 0 || maxRating < 5;
  }

  bool isCategoriesActive() {
    return categoryIds.isNotEmpty;
  }
}
