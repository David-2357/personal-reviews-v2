import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_reviews/domain/models/category.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/item.dart';

part 'review.freezed.dart';

@freezed
abstract class ReviewDomain with _$ReviewDomain {
  const factory ReviewDomain({
    required int id,
    required String comment,
    required double rating, // 0.0 to 5.0

    required DateTime createdAt,
    DateTime? updatedAt,

    required int itemId,
    Map<int, String>? images, // image id and path

    @Default(false) bool isDeleted,
    DateTime? deletedAt,
  }) = _ReviewDomain;
}

@freezed
abstract class ReviewDetailed with _$ReviewDetailed {
  const factory ReviewDetailed({
    required ReviewDomain review,
    ItemDomain? item,
    CategoryDomain? category,
    @Default([]) List<FolderDomain> folderPath,
  }) = _ReviewDetailed;
}

@freezed
abstract class ReviewFormImage with _$ReviewFormImage {
  const factory ReviewFormImage({required String path, int? id}) =
      _ReviewFormImage;

  const ReviewFormImage._();

  bool get exists => id != null;
}

@freezed
abstract class ReviewForm with _$ReviewForm {
  const factory ReviewForm({
    @Default(0) int reviewId,
    @Default(0.0) double rating,
    @Default('') String comment,
    @Default([]) List<ReviewFormImage> images,

    @Default('') String itemName,
    int? categoryId,
    String? categoryName,
    @Default([]) List<FolderDomain> folderPath,
    int? itemId,
  }) = _ReviewForm;

  const ReviewForm._();

  bool get reviewExists => reviewId != 0;
  bool get itemExists => itemId != null;
  List<String> get imagePaths => images.map((e) => e.path).toList();
  bool get hasImages => images.isNotEmpty;
  bool get categoryExists => categoryId != null;
}
