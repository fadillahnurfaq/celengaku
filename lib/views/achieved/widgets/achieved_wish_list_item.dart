import 'dart:io';

import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/achieved_extension.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:celenganku/views/achieved_detail/achieved_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/bloc/achieved/achieved_bloc.dart';

class AchievedWishListItem extends StatelessWidget {
  final WishModel wish;
  const AchievedWishListItem({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final imagePath = wish.imagePath;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(wish.name, style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          color: imagePath != null
                              ? null
                              : theme.colorScheme.surfaceVariant,
                          image: imagePath != null
                              ? DecorationImage(
                                  image: FileImage(File(imagePath)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(10),
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
                    ),
                  ),
                  Text("Rp. ${wish.savingTarget.toCurrency()}",
                      style: const TextStyle(fontSize: 24)),
                  const Divider(),
                  Center(
                    child: Text(
                      "Tercapai Dalam Waktu ${wish.durationToAchieve()} ${WishModel.savingPlanTimeName(wish.savingPlan)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: theme.colorScheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AchievedDetailView(wish: wish),
                          ))
                      .then((_) => context
                          .read<AchievedBloc>()
                          .add(GetAchievedWishEvent()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
