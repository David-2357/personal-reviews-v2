import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/data/repositories/item_review_repository.dart';
import 'package:personal_reviews/providers/repositories_provider.dart';

final itemReviewProvider = Provider<ItemReviewRepository>((ref) {
  return ref.watch(itemReviewRepositoryProvider);
});
