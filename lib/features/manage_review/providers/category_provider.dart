import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/providers/repositories_provider.dart';
import 'package:personal_reviews/domain/models/category.dart';

final allCategoriesProvider = FutureProvider.autoDispose<List<CategoryDomain>>((
  ref,
) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return categoryRepository.getAll(false);
});
