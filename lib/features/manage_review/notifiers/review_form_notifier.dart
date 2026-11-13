import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/review.dart';

class ReviewFormNotifier extends StateNotifier<ReviewForm> {
  ReviewFormNotifier()
    : super(ReviewForm(rating: 0, comment: '', images: const [], itemName: ''));

  void loadFromReview({required ReviewDetailed review}) {
    state = ReviewForm(
      rating: review.review.rating,
      comment: review.review.comment,
      images: review.review.images != null
          ? review.review.images!.entries
                .map((e) => ReviewFormImage(id: e.key, path: e.value))
                .toList()
          : const [],
      itemId: review.item?.id,
      itemName: review.item?.name ?? '',
      categoryId: review.category?.id,
      folderPath: review.folderPath,
    );
  }

  void loadFromForm({required ReviewForm form}) {
    state = form;
  }

  void updateRating(double rating) {
    state = state.copyWith(rating: rating);
  }

  void updateComment(String comment) {
    state = state.copyWith(comment: comment);
  }

  void updateItemName(String name) {
    state = state.copyWith(itemName: name);
  }

  void updateCategory(int categoryId, String categoryName) {
    state = state.copyWith(categoryId: categoryId, categoryName: categoryName);
  }

  void updateFolderPath(List<FolderDomain> folders) {
    debugPrint(
      'Updating folder path: ${folders.map((f) => f.name).join(' / ')}',
    );
    state = state.copyWith(folderPath: folders);
  }

  void updateItemId(int? id) {
    state = state.copyWith(itemId: id);
  }

  void addExistingImage(int id, String path) {
    final image = ReviewFormImage(id: id, path: path);
    state = state.copyWith(images: [...state.images, image]);
  }

  void removeImageById(int id) {
    state = state.copyWith(
      images: state.images.where((e) => e.id != id).toList(),
    );
  }

  void addNewImage(String path) {
    final image = ReviewFormImage(path: path);
    state = state.copyWith(images: [...state.images, image]);
  }

  void removeImageByPath(String path) {
    state = state.copyWith(
      images: state.images.where((e) => e.path != path).toList(),
    );
  }

  void replaceImagesByPaths(List<String> imagePaths) {
    final currentByPath = {for (final image in state.images) image.path: image};

    state = state.copyWith(
      images: imagePaths
          .map((path) => currentByPath[path] ?? ReviewFormImage(path: path))
          .toList(),
    );
  }

  void replaceImages(List<ReviewFormImage> images) {
    state = state.copyWith(images: images);
  }

  void reset() {
    state = ReviewForm(rating: 0, comment: '', images: const [], itemName: '');
  }
}

final reviewFormProvider =
    StateNotifierProvider.autoDispose<ReviewFormNotifier, ReviewForm>(
      (ref) => ReviewFormNotifier(),
    );
