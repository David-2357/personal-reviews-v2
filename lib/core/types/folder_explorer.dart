import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_reviews/core/types/elements_filter.dart';
import 'package:personal_reviews/core/types/elements_sort.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/domain/models/item.dart';
part 'folder_explorer.freezed.dart';

@freezed
abstract class FolderExplorerConfig with _$FolderExplorerConfig {
  const factory FolderExplorerConfig({
    /* DB Options */
    @Default(true) bool groupByFolders,
    int? folderId,
    @Default(false) bool includeDeleted,
    @Default(false) bool excludeNonDeleted,

    /* UI options */
    @Default(true) bool showSearch,
    @Default(true) bool showSort,
    @Default(true) bool showFilter,
    @Default(true) bool showCategoriesFilter,
    @Default(true) bool showVisibilityFilter,

    /* Default filter and sort */
    @Default(ElementsFilter()) ElementsFilter defaultFilter,
    @Default(ElementsSort()) ElementsSort defaultSort,
  }) = _FolderExplorerConfig;
}

@freezed
abstract class FolderExplorerData with _$FolderExplorerData {
  const factory FolderExplorerData({
    @Default(false) bool hasFolders,
    @Default(false) bool hasItems,
    @Default([]) List<FolderDetailed> folders,
    @Default([]) List<ItemWithLastReview> items,
  }) = _FolderExplorerData;
}

@freezed
abstract class FolderExplorerParams with _$FolderExplorerParams {
  const factory FolderExplorerParams({
    required FolderExplorerConfig config,
    required FolderExplorerData data,
  }) = _FolderExplorerParams;
}
