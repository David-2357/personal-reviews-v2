import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_reviews/shared/widgets/app_snackbar.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/style/theme/app_colors.dart';

class PhotoPickerField extends StatefulWidget {
  const PhotoPickerField({
    super.key,
    required this.imagePaths,
    required this.onImageAdded,
    required this.onImageRemoved,
    this.maxImages = 10,
  });

  final List<String> imagePaths;
  final ValueChanged<String> onImageAdded;
  final ValueChanged<String> onImageRemoved;
  final int maxImages;

  @override
  State<PhotoPickerField> createState() => _PhotoPickerFieldState();
}

class _PhotoPickerFieldState extends State<PhotoPickerField> {
  final ImagePicker _picker = ImagePicker();

  late List<XFile> _images;

  @override
  void initState() {
    super.initState();
    _images = widget.imagePaths.map(XFile.new).toList();
  }

  @override
  void didUpdateWidget(covariant PhotoPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imagePaths == widget.imagePaths) {
      return;
    }

    _images = widget.imagePaths.map(XFile.new).toList();
  }

  bool get _isMaxReached => _images.length >= widget.maxImages;

  String get _counter => '${_images.length}/${widget.maxImages}';

  bool _isLoading = false;
  bool get _buttonsEnabled => !_isLoading && !_isMaxReached;

  void _showMaxImagesMessage() {
    AppSnackbar.showWarning(
      context,
      'Límite de ${widget.maxImages} fotos alcanzado.',
    );
  }

  Future<void> _pickFromGallery() async {
    if (!_buttonsEnabled) {
      if (_isMaxReached) {
        _showMaxImagesMessage();
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      final remaining = widget.maxImages - _images.length;

      final images = await _picker.pickMultiImage(
        imageQuality: 85,
        limit: remaining,
      );

      if (images.isEmpty) return;

      setState(() {
        _images.addAll(images.take(remaining));
      });

      for (final image in images.take(remaining)) {
        widget.onImageAdded(image.path);
      }

      if (images.length > remaining) {
        _showMaxImagesMessage();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _takePhoto() async {
    if (!_buttonsEnabled) {
      if (_isMaxReached) {
        _showMaxImagesMessage();
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return;

      setState(() {
        _images.add(image);
      });

      widget.onImageAdded(image.path);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _removeImage(int index) {
    final image = _images[index];

    setState(() {
      _images.removeAt(index);
    });

    widget.onImageRemoved(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: AppSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Añade unas fotos', style: theme.textTheme.bodyMedium),
            const Spacer(),
            Text(
              _counter,
              style: theme.textTheme.bodySmall?.copyWith(
                color: _isMaxReached
                    ? AppColors.warning
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),

        Row(
          spacing: AppSpacing.sm,
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _takePhoto,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.camera_alt),
                label: const Text('Hacer foto'),
              ),
            ),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickFromGallery,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.image),
                label: const Text('Galería'),
              ),
            ),
          ],
        ),

        if (_images.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _images.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, index) {
                final image = _images[index];

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: AppRadius.lg,
                      child: Image.file(
                        File(image.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 14,
                          color: Colors.white,
                          onPressed: () => _removeImage(index),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
