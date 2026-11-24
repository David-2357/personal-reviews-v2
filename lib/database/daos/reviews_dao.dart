import 'package:drift/drift.dart';
import 'package:personal_reviews/database/app_database.dart';
import 'package:personal_reviews/database/tables/reviews_table.dart';
part 'reviews_dao.g.dart';

@DriftAccessor(tables: [Reviews])
class ReviewsDao extends DatabaseAccessor<AppDatabase> with _$ReviewsDaoMixin {
  ReviewsDao(super.attachedDatabase);

  Future<List<Review>> getAll(bool isDeleted) {
    return (select(reviews)..where((t) => t.isDeleted.equals(isDeleted))).get();
  }

  Future<Review?> getById(int id) {
    return (select(reviews)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Review>> getByItemId(int itemId) {
    return (select(
      reviews,
    )..where((t) => t.itemId.equals(itemId) & t.isDeleted.equals(false))).get();
  }

  Future<List<Review>> getByItemIds(List<int> itemIds) {
    return (select(
      reviews,
    )..where((t) => t.itemId.isIn(itemIds) & t.isDeleted.equals(false))).get();
  }

  Stream<List<Review>> watchAll(bool isDeleted) {
    return (select(
      reviews,
    )..where((t) => t.isDeleted.equals(isDeleted))).watch();
  }

  Future<int> create({
    String comment = '',
    required double rating,
    required int itemId,
  }) {
    return into(reviews).insert(
      ReviewsCompanion.insert(
        comment: comment,
        rating: Value(rating),
        itemId: itemId,
      ),
    );
  }

  Future<bool> updateById(
    int id, {
    required String comment,
    required double rating,
    required int itemId,
  }) {
    return (update(reviews)..where((t) => t.id.equals(id)))
        .write(
          ReviewsCompanion(
            comment: Value(comment),
            rating: Value(rating),
            itemId: Value(itemId),
            updatedAt: Value(DateTime.now()),
          ),
        )
        .then((rowsAffected) => rowsAffected > 0);
  }

  Future<bool> setDeletedById(int id, bool isDeleted) {
    return (update(reviews)..where((t) => t.id.equals(id)))
        .write(
          ReviewsCompanion(
            isDeleted: Value(isDeleted),
            deletedAt: isDeleted ? Value(DateTime.now()) : Value.absent(),
          ),
        )
        .then((rowsAffected) => rowsAffected > 0);
  }
}
