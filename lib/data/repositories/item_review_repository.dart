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

  Future<void> createOrUpdateReview(ReviewForm form) async {
    await database.transaction(() async {
      var itemId = form.itemId ?? 0;
      var categoryId = form.categoryId ?? 0;

      // Resolve the category.
      // TODO: Create a category if it does not exist.
      if (!form.categoryExists) {
        final categories = await categoryRepository.getAll(false);

        if (categories.isEmpty) {
          throw StateError('No categories available');
        }

        categoryId = categories.first.id;
      }

      // Check whether the item exists.
      final existingItem = await itemRepository.getById(itemId);
      itemId = existingItem?.id ?? 0;

      // TODO: If the item does not exist, should we create it or throw an error?

      // Create the item if it does not exist.
      if (itemId == 0) {
        final itemName = form.itemName.trim();

        if (itemName.isEmpty) {
          throw ArgumentError('Item name is required');
        }

        itemId = await itemRepository.insert(
          name: itemName,
          categoryId: categoryId,
          folderId: form.folderPath.isEmpty ? null : form.folderPath.last.id,
          imagePath: form.imagePaths.isNotEmpty ? form.imagePaths.first : null,
        );
      } else {
        // Update the item if it exists.
        await itemRepository.updateById(
          itemId,
          name: form.itemName,
          categoryId: categoryId,
          folderId: form.folderPath.isEmpty ? null : form.folderPath.last.id,
          imagePath: form.imagePaths.isNotEmpty ? form.imagePaths.first : null,
        );
      }

      // Create or update the review.
      if (form.reviewExists) {
        await reviewRepository.updateById(
          form.reviewId,
          comment: form.comment,
          rating: form.rating,
          itemId: itemId,
        );
      } else {
        await reviewRepository.create(
          comment: form.comment,
          rating: form.rating,
          itemId: itemId,
        );
      }
    });
  }
}
