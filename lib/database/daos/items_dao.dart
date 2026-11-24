import 'package:personal_reviews/core/types/elements_filter.dart';
import 'package:personal_reviews/core/types/elements_sort.dart';
import 'package:personal_reviews/core/types/sort.dart';
import 'package:personal_reviews/database/models/item_rows.dart';
import 'package:personal_reviews/database/tables/reviews_table.dart';
import 'package:personal_reviews/database/tables/items_table.dart';
import 'package:personal_reviews/database/app_database.dart';
import 'package:drift/drift.dart';
part 'items_dao.g.dart';

@DriftAccessor(tables: [Items, Reviews])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.attachedDatabase);

  OrderClauseGenerator<Items> _getOrderingClause(ElementsSort sort) {
    final isAsc = sort.type == SortType.ASC;

    switch (sort.field) {
      case ElementsSortField.creation:
        return (t) => OrderingTerm(
          expression: t.id,
          mode: isAsc ? OrderingMode.asc : OrderingMode.desc,
        );

      case ElementsSortField.name:
        return (t) => OrderingTerm(
          expression: t.name,
          mode: isAsc ? OrderingMode.asc : OrderingMode.desc,
        );

      default:
        return (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc);
    }
  }

  Future<List<Item>> getAll(bool isDeleted) {
    return (select(items)..where((t) => t.isDeleted.equals(isDeleted))).get();
  }

  Future<Item?> getById(int id) {
    return (select(items)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<List<Item>> watchAll(bool isDeleted) {
    return (select(items)..where((t) => t.isDeleted.equals(isDeleted))).watch();
  }

  Future<int> create({
    required String name,
    required int categoryId,
    int? folderId,
    String? imagePath,
  }) {
    return into(items).insert(
      ItemsCompanion.insert(
        name: name,
        categoryId: categoryId,
        folderId: Value(folderId),
        imagePath: Value(imagePath),
      ),
    );
  }

  Future<bool> updateById(
    int id, {
    required String name,
    required int categoryId,
    int? folderId,
    String? imagePath,
  }) {
    return (update(items)..where((t) => t.id.equals(id)))
        .write(
          ItemsCompanion(
            name: Value(name),
            categoryId: Value(categoryId),
            folderId: Value(folderId),
            imagePath: Value(imagePath),
            updatedAt: Value(DateTime.now()),
          ),
        )
        .then((rowsAffected) => rowsAffected > 0);
  }

  Future<bool> updateImagePathById(int id, String? imagePath) {
    return (update(items)..where((t) => t.id.equals(id)))
        .write(
          ItemsCompanion(
            imagePath: Value(imagePath),
            updatedAt: Value(DateTime.now()),
          ),
        )
        .then((rowsAffected) => rowsAffected > 0);
  }

  Future<bool> setDeletedById(int id, bool isDeleted) {
    return (update(items)..where((t) => t.id.equals(id)))
        .write(
          ItemsCompanion(
            isDeleted: Value(isDeleted),
            deletedAt: isDeleted ? Value(DateTime.now()) : Value.absent(),
          ),
        )
        .then((rowsAffected) => rowsAffected > 0);
  }

  Future<List<ItemWithLastReviewRow>> queryItems({
    required ElementsSort sort,
    required ElementsFilter filter,
    String searchQuery = '',
    int? folderId,
    bool groupByFolders = false,
    bool includeDeleted = false,
    bool excludeNonDeleted = false,
  }) async {
    /* Sort */
    final ordering = _getOrderingClause(sort);

    /* Filter */
    final categoriesAllowedFilter = filter.categoryIds.isNotEmpty
        ? items.categoryId.isIn(filter.categoryIds)
        : const Constant(true);

    /* Search */
    final searchFilter = searchQuery.isNotEmpty
        ? items.name.like('%$searchQuery%')
        : const Constant(true);

    /* Other options */
    final groupByFoldersFilter = groupByFolders
        ? (folderId != null
              ? items.folderId.equals(folderId)
              : items.folderId.isNull())
        : (folderId != null
              ? items.folderId.equals(folderId)
              : const Constant(true));

    final includeDeletedFilter = includeDeleted
        ? const Constant(true)
        : items.isDeleted.equals(false);

    final excludeNonDeletedFilter = excludeNonDeleted
        ? items.isDeleted.equals(true)
        : const Constant(true);

    /* Query */
    final itemsRows =
        await (select(items)
              ..where(
                (tbl) =>
                    categoriesAllowedFilter &
                    searchFilter &
                    groupByFoldersFilter &
                    includeDeletedFilter &
                    excludeNonDeletedFilter,
              )
              ..orderBy([ordering]))
            .get();

    final itemIds = itemsRows.map((item) => item.id).toList();

    /* Get latest reviews for the items */
    final latestReviewsByItemId = await _getLatestReviewsByItemIds(
      itemIds,
      includeDeleted,
      excludeNonDeleted,
    );

    /* Map items to ItemWithLastReviewRow */
    final result = itemsRows
        .map(
          (item) => ItemWithLastReviewRow(
            item: item,
            lastReview: latestReviewsByItemId[item.id],
          ),
        )
        .where((row) {
          final rating = row.lastReview?.rating ?? 0;
          final ratingRange =
              rating >= filter.minRating && rating <= filter.maxRating;
          return ratingRange;
        })
        .toList();

    /* Sort by rating if needed */
    if (sort.field == ElementsSortField.rating) {
      result.sort((a, b) {
        final ratingA = a.lastReview?.rating ?? 0;
        final ratingB = b.lastReview?.rating ?? 0;

        return sort.type == SortType.ASC
            ? ratingA.compareTo(ratingB)
            : ratingB.compareTo(ratingA);
      });
    }

    /* Sort by review date if needed */
    if (sort.field == ElementsSortField.date) {
      result.sort((a, b) {
        final dateA = a.lastReview?.createdAt ?? DateTime(9999, 12, 31);
        final dateB = b.lastReview?.createdAt ?? DateTime(9999, 12, 31);

        return sort.type == SortType.ASC
            ? dateA.compareTo(dateB)
            : dateB.compareTo(dateA);
      });
    }

    return result;
  }

  Future<Map<int, Review>> _getLatestReviewsByItemIds(
    List<int> itemIds,
    bool includeDeleted,
    bool excludeNonDeleted,
  ) async {
    if (itemIds.isEmpty) {
      return {};
    }

    final includeDeletedReviewsFilter = includeDeleted
        ? const Constant(true)
        : reviews.isDeleted.equals(false);

    final excludeNonDeletedReviewsFilter = excludeNonDeleted
        ? reviews.isDeleted.equals(true)
        : const Constant(true);

    final allReviews =
        await (select(reviews)
              ..where(
                (r) =>
                    r.itemId.isIn(itemIds) &
                    includeDeletedReviewsFilter &
                    excludeNonDeletedReviewsFilter,
              )
              ..orderBy([
                (r) => OrderingTerm.desc(r.createdAt),
                (r) => OrderingTerm.desc(r.id),
              ]))
            .get();

    final result = <int, Review>{};

    for (final review in allReviews) {
      result.putIfAbsent(review.itemId, () => review);
    }

    return result;
  }
}
