import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/domain/models/folder.dart';
import 'package:flutter/material.dart';

class FolderPathSelector extends StatefulWidget {
  const FolderPathSelector({
    super.key,
    this.selectedPath,
    required this.rootFolders,
    this.onFolderSelected,
  });

  final List<FolderDomain>? selectedPath;
  final List<FolderWithChildren> rootFolders;
  // Emit the change
  final void Function(List<FolderWithChildren> selectedPath)? onFolderSelected;

  @override
  State<FolderPathSelector> createState() => _FolderPathSelectorState();
}

class _FolderPathSelectorState extends State<FolderPathSelector> {
  final List<FolderWithChildren> _folderPath = [];
  FolderWithChildren? _selectedFolder;

  List<FolderWithChildren> get _visibleFolders =>
      _folderPath.isEmpty ? widget.rootFolders : _folderPath.last.children;

  //Oninit
  @override
  void initState() {
    super.initState();

    if (widget.selectedPath != null && widget.selectedPath!.isNotEmpty) {
      // Build the folder path from the selected path
      final selectedPath = widget.selectedPath!;
      final rootFolder = widget.rootFolders.firstWhere(
        (folder) => folder.folder.id == selectedPath.first.id,
        orElse: () => widget.rootFolders.first,
      );

      if (selectedPath.length == 1) {
        _selectedFolder = rootFolder;
        return;
      }

      _folderPath.add(rootFolder);

      for (var i = 1; i < selectedPath.length; i++) {
        final parentFolder = _folderPath.last;
        final childFolder = parentFolder.children.firstWhere(
          (folder) => folder.folder.id == selectedPath[i].id,
          orElse: () => parentFolder.children.first,
        );

        if (i == selectedPath.length - 1) {
          _selectedFolder = childFolder;
        } else {
          _folderPath.add(childFolder);
        }
      }
    }
  }

  void _selectFolder(FolderWithChildren folder) {
    setState(() {
      _selectedFolder = folder;
    });
  }

  void _openFolder(FolderWithChildren folder) {
    setState(() {
      _folderPath.add(folder);
      _selectedFolder = folder;
    });
  }

  void _goBack() {
    if (_folderPath.isEmpty) return;

    setState(() {
      _folderPath.removeLast();

      bool goingBackToSameFolder = _folderPath.isEmpty
          ? false
          : _folderPath.last.folder.id == _selectedFolder?.folder.id;

      if (goingBackToSameFolder) {
        _folderPath.removeLast();
      }
      _selectedFolder = _folderPath.isEmpty ? null : _folderPath.last;
    });
  }

  void _confirmSelection() {
    if (_folderPath.isNotEmpty &&
        _selectedFolder?.folder.id == _folderPath.last.folder.id) {
      _folderPath.removeLast();
    }

    List<FolderWithChildren> finalPath = [..._folderPath, ?_selectedFolder];

    widget.onFolderSelected?.call(
      finalPath.whereType<FolderWithChildren>().toList(),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      title: Row(
        spacing: AppSpacing.sm,
        children: [
          if (_folderPath.isNotEmpty)
            IconButton(
              tooltip: 'Volver',
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          Expanded(
            child: Text('Ubicación', style: context.textTheme.titleLarge),
          ),
          IconButton(
            tooltip: 'Cerrar',
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_folderPath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  _folderPath.map((folder) => folder.folder.name).join(' / '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
            if (_visibleFolders.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Text('Esta carpeta no tiene subcarpetas.'),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _visibleFolders.length,
                  itemBuilder: (context, index) {
                    final folder = _visibleFolders[index];
                    final hasChildren = folder.children.isNotEmpty;
                    final isSelected =
                        _selectedFolder?.folder.id == folder.folder.id;

                    return FolderListTile(
                      folder: folder,
                      isSelected: isSelected,
                      hasChildren: hasChildren,
                      onTap: () => hasChildren
                          ? _openFolder(folder)
                          : _selectFolder(folder),
                      onSelect: () => _selectFolder(folder),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              _folderPath.isEmpty ? Navigator.of(context).pop() : _goBack(),
          child: Text(
            _folderPath.isEmpty ? 'Cancelar' : 'Atras',
            style: TextStyle(color: context.colors.onSurfaceVariant),
          ),
        ),
        FilledButton(
          onPressed: _confirmSelection,
          child: const Text('Seleccionar carpeta'),
        ),
      ],
    );
  }
}

// Separate widget for the folder list tile
class FolderListTile extends StatelessWidget {
  const FolderListTile({
    super.key,
    required this.folder,
    required this.isSelected,
    required this.hasChildren,
    required this.onTap,
    required this.onSelect,
  });

  final FolderWithChildren folder;
  final bool isSelected;
  final bool hasChildren;
  final VoidCallback onTap;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      leading: const Icon(Icons.folder_rounded),
      title: Text(folder.folder.name),
      subtitle: hasChildren
          ? Text('${folder.children.length} subcarpetas')
          : null,
      onTap: onTap,
      trailing: IconButton(
        tooltip: 'Seleccionar carpeta',
        onPressed: onSelect,
        icon: const Icon(Icons.check_circle_outline_rounded),
      ),
    );
  }
}
