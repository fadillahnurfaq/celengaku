import 'dart:io';

import 'package:celenganku/controllers/bloc/on_going/on_going_bloc.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:celenganku/views/wish_detail/wish_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingContent extends StatelessWidget {
  final WishModel wish;
  const OngoingContent({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final String? imagePath = wish.imagePath;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    wish.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: imagePath != null
                            ? null
                            : theme.colorScheme.surfaceVariant,
                        image: imagePath != null
                            ? DecorationImage(
                                image: FileImage(
                                  File(imagePath),
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
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
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. ${wish.savingTarget.toCurrency()}",
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          Text(
                            "Rp. ${wish.savingNominal.toCurrency()} / ${WishModel.savingPlanTimeName(wish.savingPlan).toLowerCase()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.scale(
                            scale: 1.2,
                            child: CircularProgressIndicator.adaptive(
                              value: wish.getSavingPercentage() / 100,
                              backgroundColor: theme.primaryColorLight,
                            ),
                          ),
                          Text(
                            "${wish.getSavingPercentage().toStringAsFixed(0)}%",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Divider(),
                  Center(
                    child: Text(
                      "Estimasi : ${wish.getEstimatedRemainingTime()} ${WishModel.savingPlanTimeName(wish.savingPlan)} Lagi",
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
                splashColor: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishDetailView(wish: wish),
                      )).then((_) => context.read<OnGoingBloc>()
                    ..add(const GetWishListEvent()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
