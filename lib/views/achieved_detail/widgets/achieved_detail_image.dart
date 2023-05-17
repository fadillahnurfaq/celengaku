import 'dart:io';

import 'package:flutter/material.dart';

class AchievedDetailImage extends StatelessWidget {
  final String? imagePath;
  final ThemeData theme;
  const AchievedDetailImage({
    super.key,
    required this.imagePath,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
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
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
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
