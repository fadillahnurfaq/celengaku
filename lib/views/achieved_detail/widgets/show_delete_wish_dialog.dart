import 'package:celenganku/models/wish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/bloc/achieved/achieved_bloc.dart';

class ShowDeleteWishDialog extends StatelessWidget {
  final WishModel wish;
  const ShowDeleteWishDialog({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      contentPadding: EdgeInsets.zero,
      title: const Text('Hapus tabungan?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<AchievedBloc>().add(DeleteAchievedWishEvent(wish));
          },
          child: const Text('Hapus'),
        )
      ],
    );
  }
}
