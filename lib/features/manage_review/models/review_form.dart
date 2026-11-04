import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/item.dart';
import 'package:personal_reviews/domain/models/review.dart';

part 'review_form.freezed.dart';

@freezed
abstract class ItemImage with _$ItemImage {
  const factory ItemImage({required String path, int? id}) = _ItemImage;

  const ItemImage._();

  bool get exists => id != null;
}

@freezed
abstract class ReviewForm with _$ReviewForm {
  const factory ReviewForm({
    @Default(0.0) double rating,
    @Default('') String comment,
    @Default([]) List<ItemImage> images,

    @Default('') String itemName,
    CategoryDomain? category,
    @Default([]) List<FolderDomain> folderPath,
    int? itemId,
  }) = _ReviewForm;

  const ReviewForm._();

  bool get itemExists => itemId != null;

  List<String> get imagePaths => images.map((e) => e.path).toList();

  ReviewDetailed toReviewDetailed() {
    return ReviewDetailed(
      review: ReviewDomain(
        id: 0,
        comment: comment,
        rating: rating,
        itemId: itemId ?? 0,
        createdAt: DateTime.now(),
      ),
      item: ItemDomain(
        id: itemId ?? 0,
        name: itemName,
        categoryId: category?.id ?? 0,
        folderId: folderPath.isNotEmpty ? folderPath.last.id : null,
        imagePath: images.isNotEmpty ? images.first.path : null,
        createdAt: DateTime.now(),
      ),
      category: category,
    );
  }
}
