import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_reviews/data/mappers/folder_mapper.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:personal_reviews/providers/repositories_provider.dart';

final foldersProvider = FutureProvider.autoDispose<List<FolderWithChildren>>((
  ref,
) async {
  try {
    final repository = ref.watch(folderRepositoryProvider);
    final folders = await repository.getAll(false);
    final result = FolderWithChildrenMapper.convertToTree(folders);

    return result;
  } catch (error) {
    rethrow;
  }
});
