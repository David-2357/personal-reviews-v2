import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/review.dart';

class ReviewFormNotifier extends StateNotifier<ReviewForm> {
  ReviewFormNotifier()
    : super(ReviewForm(rating: 0, comment: '', images: const [], itemName: ''));

  var _initialState = ReviewForm(
    rating: 0,
    comment: '',
    images: const [],
    itemName: '',
  );

  bool hasChanges() {
    return state.rating != _initialState.rating ||
        state.comment != _initialState.comment ||
        state.itemName != _initialState.itemName ||
        state.categoryId != _initialState.categoryId ||
        (state.folderPath.every(
              (folder) => !_initialState.folderPath.contains(folder),
            ) &&
            state.folderPath.length != _initialState.folderPath.length) ||
        state.itemId != _initialState.itemId ||
        state.images.length != _initialState.images.length ||
        !state.images.every((image) => _initialState.images.contains(image));
  }

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

    _initialState = state;
  }

  void loadFromForm({required ReviewForm form}) {
    state = form;
    _initialState = state;
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

  void updateCategory(int? categoryId, String? categoryName) {
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
    state = _initialState;
  }

  /// Valida el formulario de revisión y devuelve una lista de campos faltantes en español para mostrar al usuario.
  ///
  /// @return List - Una lista de errores que indica los campos faltantes
  List<String> validate() {
    final errors = <String>[];

    if (state.itemName.trim().isEmpty) {
      errors.add('el nombre del objetivo');
    }

    if (state.categoryId == null || state.categoryId! <= 0) {
      errors.add('la categoría');
    }

    return errors;
  }
}

final reviewFormProvider =
    StateNotifierProvider.autoDispose<ReviewFormNotifier, ReviewForm>(
      (ref) => ReviewFormNotifier(),
    );
