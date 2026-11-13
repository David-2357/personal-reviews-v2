import 'package:personal_reviews/data/mappers/review_mapper.dart';
import 'package:personal_reviews/database/app_database.dart';
import 'package:personal_reviews/database/daos/review_images_dao.dart';
import 'package:personal_reviews/database/daos/reviews_dao.dart';
import 'package:personal_reviews/domain/models/review.dart';

class ReviewRepository {
  final ReviewsDao _reviewsDao;
  final ReviewImagesDao _reviewImagesDao;

  ReviewRepository(this._reviewsDao, this._reviewImagesDao);

  Future<ReviewDomain> _convertToDomain(Review review) async {
    final images = await _reviewImagesDao.getByReviewId(review.id);
    return ReviewMapper.fromRow(review, images);
  }

  Future<List<ReviewDomain>> _convertListToDomain(List<Review> reviews) async {
    List<int> reviewIds = reviews.map((r) => r.id).toList();
    final List<ReviewImage> images = await _reviewImagesDao.getByReviewIds(
      reviewIds,
    );

    return ReviewMapper.fromRows(reviews, images);
  }

  Future<List<ReviewDomain>> getAll(bool isDeleted) {
    return _reviewsDao
        .getAll(isDeleted)
        .then((reviews) => ReviewMapper.fromRows(reviews, null));
  }

  Future<ReviewDomain?> getById(int id) {
    return _reviewsDao.getById(id).then((review) {
      return review != null ? ReviewMapper.fromRow(review, null) : null;
    });
  }

  Future<ReviewDomain?> getByIdWithImages(int id) {
    return _reviewsDao.getById(id).then((review) {
      if (review != null) {
        return _convertToDomain(review);
      } else {
        return null;
      }
    });
  }

  Future<List<ReviewDomain>> getByItemId(int itemId, bool isDeleted) {
    return _reviewsDao.getByItemId(itemId).then((reviews) async {
      return _convertListToDomain(reviews);
    });
  }

  Stream<List<ReviewDomain>> watchAll(bool isDeleted) {
    return _reviewsDao
        .watchAll(isDeleted)
        .map((rows) => ReviewMapper.fromRows(rows, null));
  }

  Future<int> create({
    String comment = '',
    required double rating,
    required int itemId,
  }) {
    return _reviewsDao.create(comment: comment, rating: rating, itemId: itemId);
  }

  Future<bool> updateById(
    int id, {
    required String comment,
    required double rating,
    required int itemId,
  }) {
    return _reviewsDao.updateById(
      id,
      comment: comment,
      rating: rating,
      itemId: itemId,
    );
  }

  Future<bool> deleteById(int id) {
    return _reviewsDao.setDeletedById(id, true);
  }

  Future<bool> restoreById(int id) {
    return _reviewsDao.setDeletedById(id, false);
  }
}
