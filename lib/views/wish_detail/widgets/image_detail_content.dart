import 'dart:io';

import 'package:flutter/material.dart';

class ImageDetailContent extends StatelessWidget {
  final String? imagePath;
  const ImageDetailContent({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: imagePath != null ? null : theme.colorScheme.surfaceVariant,
          image: imagePath != null
              ? DecorationImage(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: imagePath != null
            ? null
            : Center(
                child: Icon(
                  Icons.landscape_outlined,
                  size: 100,
                  color: theme.colorScheme.primary,
                ),
              ),
      ),
    );
  }
}
