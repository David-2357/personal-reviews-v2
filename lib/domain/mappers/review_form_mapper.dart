import 'package:personal_reviews/domain/models/review.dart';

class ReviewFormMapper {
  static ReviewForm toReviewForm(ReviewDetailed review) {
    return ReviewForm(
      reviewId: review.review.id,
      categoryId: review.item?.categoryId,
      categoryName: review.category?.name,
      rating: review.review.rating,
      comment: review.review.comment,
      images: review.review.images != null
          ? review.review.images!.entries
                .map((e) => ReviewFormImage(id: e.key, path: e.value))
                .toList()
          : const [],
      itemId: review.item?.id,
      itemName: review.item?.name ?? '',
      folderPath: review.folderPath,
    );
  }
}
