import 'package:personal_reviews/data/repositories/category_repository.dart';
import 'package:personal_reviews/data/repositories/item_repository.dart';
import 'package:personal_reviews/data/repositories/review_repository.dart';
import 'package:personal_reviews/database/app_database.dart';
import 'package:personal_reviews/domain/models/review.dart';

// TODO: Move to a service?
class ItemReviewRepository {
  final AppDatabase database;
  final ReviewRepository reviewRepository;
  final ItemRepository itemRepository;
  final CategoryRepository categoryRepository;

  ItemReviewRepository(
    this.database,
    this.reviewRepository,
    this.itemRepository,
    this.categoryRepository,
  );

  Future<void> createOrUpdateReview(ReviewDetailed review) async {
    await database.transaction(() async {
      var itemId = review.item?.id ?? 0;
      var categoryId = review.item?.categoryId ?? 0;

      // Resolve the category.
      // TODO: Create a category if it does not exist.
      if (categoryId == 0) {
        final categories = await categoryRepository.getAll(false);

        if (categories.isEmpty) {
          throw StateError('No categories available');
        }

        categoryId = categories.first.id;
      }

      // Check whether the item exists.
      if (itemId != 0) {
        final existingItem = await itemRepository.getById(itemId);

        itemId = existingItem?.id ?? 0;
        // TODO: If the item does not exist, should we create it or throw an error?
      }

      // Create the item if it does not exist.
      if (itemId == 0) {
        final itemName = review.item?.name.trim() ?? '';

        if (itemName.isEmpty) {
          throw ArgumentError('Item name is required');
        }

        itemId = await itemRepository.insert(
          name: itemName,
          categoryId: categoryId,
          folderId: review.item?.folderId,
          imagePath: review.item?.imagePath,
        );
      }

      // Create or update the review.
      if (review.review.id != 0) {
        await reviewRepository.updateById(
          review.review.id,
          comment: review.review.comment,
          rating: review.review.rating,
          itemId: itemId,
        );
      } else {
        await reviewRepository.create(
          comment: review.review.comment,
          rating: review.review.rating,
          itemId: itemId,
        );
      }
    });
  }
}
