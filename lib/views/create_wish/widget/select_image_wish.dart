import 'dart:io';

import 'package:celenganku/controllers/bloc/add_wish/add_wish_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constant.dart';

class SelectImageWish extends StatelessWidget {
  const SelectImageWish({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<AddWishBloc, AddWishState>(
      builder: (context, state) {
        String? imagePath = state.wish.imagePath;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: imagePath != null
                    ? DecorationImage(image: FileImage(File(imagePath)))
                    : null,
              ),
              child: SizedBox.expand(
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: imagePath != null
                      ? Colors.transparent
                      : theme.colorScheme.surfaceVariant,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25))),
                        builder: (_) {
                          return _selectImageSourceModal(context);
                        },
                      );
                    },
                    child: imagePath != null
                        ? null
                        : Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 100,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _selectImageSourceModal(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Pilih Sumber Gambar",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _ImageSourceListTile(
          titleText: 'Kamera',
          iconData: Icons.camera_alt_outlined,
          onTap: () async {
            String? path = await getFromCamera();

            if (path == null) return;

            if (context.mounted) {
              context
                  .read<AddWishBloc>()
                  .add(WishImageChangedEvent(imagePath: path));
            }
          },
        ),
        _ImageSourceListTile(
          titleText: 'Gallery',
          iconData: Icons.photo_library_outlined,
          onTap: () async {
            String? path = await getFromGallery();

            if (path == null) return;

            if (context.mounted) {
              // context
              //     .read<AddWishBloc>()
              //     .add(WishImageChanged(imagePath: path));
              // Navigator.pop(context);
            }
          },
        ),
      ],
    ),
  );
}

class _ImageSourceListTile extends StatelessWidget {
  const _ImageSourceListTile({
    required this.titleText,
    required this.iconData,
    required this.onTap,
  });

  final String titleText;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: Icon(iconData),
      ),
      title:
          Text(titleText, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }
}
