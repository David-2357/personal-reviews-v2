import 'package:personal_reviews/database/models/folder_rows.dart';
import 'package:personal_reviews/database/app_database.dart';
import 'package:personal_reviews/domain/models/folder.dart';

class FolderMapper {
  static FolderDomain fromRow(Folder row) {
    return FolderDomain(
      id: row.id,
      name: row.name,
      parentId: row.parentId,
      imagePath: row.imagePath,
      createdAt: row.createdAt,
      isDeleted: row.isDeleted,
      deletedAt: row.deletedAt,
    );
  }

  static List<FolderDomain> fromRows(List<Folder> rows) {
    return rows.map((row) => fromRow(row)).toList();
  }
}

class FolderDetailedMapper {
  static FolderDetailed fromRow(FolderDetailedRow row) {
    return FolderDetailed(
      folder: FolderMapper.fromRow(row.folder),
      itemCount: row.itemCount,
      previewImages: row.previewImages,
    );
  }

  static List<FolderDetailed> fromRows(List<FolderDetailedRow> rows) {
    return rows.map((row) => fromRow(row)).toList();
  }
}

class FolderWithChildrenMapper {
  static List<FolderWithChildren> convertToTree(List<FolderDomain> folders) {
    final foldersById = <int, FolderDomain>{
      for (final folder in folders) folder.id: folder,
    };

    final childrenByParentId = <int, List<FolderDomain>>{};

    for (final folder in folders) {
      final parentId = folder.parentId;

      if (parentId != null && foldersById.containsKey(parentId)) {
        childrenByParentId.putIfAbsent(parentId, () => []).add(folder);
      }
    }

    FolderWithChildren buildTree(FolderDomain folder) {
      final children = childrenByParentId[folder.id] ?? const [];

      return FolderWithChildren(
        folder: folder,
        children: [for (final child in children) buildTree(child)],
      );
    }

    return [
      for (final folder in folders)
        if (folder.parentId == null ||
            !foldersById.containsKey(folder.parentId))
          buildTree(folder),
    ];
  }

  static List<FolderDomain> flattenTree(List<FolderWithChildren> tree) {
    final List<FolderDomain> result = [];

    void traverse(FolderWithChildren node) {
      result.add(node.folder);
      for (final child in node.children) {
        traverse(child);
      }
    }

    for (final root in tree) {
      traverse(root);
    }

    return result;
  }

  static List<FolderDomain> flattenOnlyParentFolders(
    List<FolderWithChildren> folders,
  ) {
    final List<FolderDomain> result = [];
    for (final folder in folders) {
      result.add(folder.folder);
    }
    return result;
  }
}
