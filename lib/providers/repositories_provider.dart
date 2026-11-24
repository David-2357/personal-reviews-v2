import 'package:personal_reviews/data/repositories/category_repository.dart';
import 'package:personal_reviews/data/repositories/folder_repository.dart';
import 'package:personal_reviews/data/repositories/item_review_repository.dart';
import 'package:personal_reviews/data/repositories/review_repository.dart';
import 'package:personal_reviews/data/repositories/item_repository.dart';
import 'package:personal_reviews/providers/app_database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return CategoryRepository(database.categoriesDao);
});

final folderRepositoryProvider = Provider<FolderRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return FolderRepository(database.foldersDao, database.folderTreesDao);
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return ReviewRepository(database.reviewsDao, database.reviewImagesDao);
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);

  return ItemRepository(database.itemsDao);
});

final itemReviewRepositoryProvider = Provider<ItemReviewRepository>((ref) {
  return ItemReviewRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(reviewRepositoryProvider),
    ref.watch(itemRepositoryProvider),
    ref.watch(categoryRepositoryProvider),
  );
});
