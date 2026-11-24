import 'package:personal_reviews/features/folder_explorer/folder_explorer.dart';
import 'package:personal_reviews/shared/components/app_main_floating_buttons.dart';
import 'package:personal_reviews/shared/layouts/secondary_layout.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/core/types/folder_explorer.dart';
import 'package:personal_reviews/core/types/menu_action.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FolderItems extends StatelessWidget {
  const FolderItems({
    super.key,
    required this.config,
    required this.folder,
    required this.folderPath,
  });

  final FolderExplorerConfig config;
  final FolderDetailed folder;
  final List<FolderDetailed> folderPath;

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      title: 'Ver carpeta',
      actions: _buildMenuActions(folder.folder.id),
      scrollable: false,
      floatingActionButton: AppMainFloatingButtons(
        folderPath: folderPath,
        bottomPadding: true,
      ),
      child: _FolderElementsList(
        folder: folder,
        folderPath: folderPath,
        config: config,
      ),
    );
  }
}

List<MenuAction> _buildMenuActions(int folderId) {
  return [
    MenuAction(
      label: 'Editar carpeta',
      icon: Icons.edit_rounded,
      onPressed: () {
        debugPrint('Editar carpeta $folderId');
      },
    ),
    MenuAction(
      label: 'Eliminar carpeta',
      icon: Icons.delete_rounded,
      type: MenuActionType.destructive,
      onPressed: () {
        debugPrint('Eliminar carpeta $folderId');
      },
    ),
  ];
}

class _FolderElementsList extends StatelessWidget {
  const _FolderElementsList({
    required this.folder,
    required this.folderPath,
    required this.config,
  });

  final FolderDetailed folder;
  final List<FolderDetailed> folderPath;
  final FolderExplorerConfig config;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        const SizedBox(height: 0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            if (folder.folder.parentId != null)
              _FolderBreadcrumbs(folderPath: folderPath, folder: folder),

            _FolderHeader(folder: folder),
          ],
        ),

        Divider(
          height: 1,
          thickness: 1,
          color: context.colors.onSurfaceVariant.withValues(alpha: 0.3),
        ),

        Expanded(
          child: FolderExplorer(
            folderPath: folderPath,
            config: config.copyWith(folderId: folder.folder.id),
          ),
        ),
      ],
    );
  }
}

class _FolderHeader extends StatelessWidget {
  final FolderDetailed folder;

  const _FolderHeader({required this.folder});

  @override
  Widget build(BuildContext context) {
    final imagePath = folder.folder.imagePath;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      spacing: AppSpacing.md,
      children: [
        imagePath == null || !File(imagePath).existsSync()
            ? Icon(
                Icons.folder_rounded,
                color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
                size: 50,
              )
            : ClipRRect(
                borderRadius: AppRadius.sm,
                child: Image.file(
                  File(imagePath),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
                ),
              ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.6,
              ),
              child: Text(
                folder.folder.name.isNotEmpty
                    ? folder.folder.name
                    : 'Carpeta sin nombre',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '${folder.itemCount} reseñas',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FolderBreadcrumbs extends StatelessWidget {
  final List<FolderDetailed> folderPath;
  final FolderDetailed folder;

  const _FolderBreadcrumbs({required this.folderPath, required this.folder});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        for (final ancestor in folderPath)
          if (ancestor.folder.id != folder.folder.id)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.popUntil(
                      context,
                      (route) =>
                          route.settings.name ==
                          'folder_items/${ancestor.folder.id}',
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    child: Text(
                      ancestor.folder.name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: AppSizes.md,
                  color: context.colors.onSurfaceVariant,
                ),
              ],
            ),
      ],
    );
  }
}
