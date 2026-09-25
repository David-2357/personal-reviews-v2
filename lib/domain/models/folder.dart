import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_reviews/domain/models/item.dart';

part 'folder.freezed.dart';

@freezed
abstract class FolderDomain with _$FolderDomain {
  const factory FolderDomain({
    required int id,
    required String name,
    String? imagePath,
    int? parentId,
    required DateTime createdAt,

    @Default(false) bool isDeleted,
    DateTime? deletedAt,
  }) = _FolderDomain;
}

@freezed
abstract class FolderDetailed with _$FolderDetailed {
  const factory FolderDetailed({
    required FolderDomain folder,
    required int itemCount,
    required List<String> previewImages,
  }) = _FolderDetailed;
}

@freezed
abstract class FolderWithChildren with _$FolderWithChildren {
  const factory FolderWithChildren({
    required FolderDomain folder,
    @Default([]) List<FolderWithChildren> children,
  }) = _FolderWithChildren;
}

/* Folder content */
@freezed
abstract class FolderContent with _$FolderContent {
  const factory FolderContent({
    @Default([]) List<FolderDetailed> folders,
    @Default([]) List<ItemWithLastReview> items,
  }) = _FolderContent;
}
