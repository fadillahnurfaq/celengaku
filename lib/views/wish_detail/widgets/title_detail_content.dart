import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:flutter/material.dart';

class TitleDetailContent extends StatelessWidget {
  final WishModel wish;
  const TitleDetailContent({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rp. ${wish.savingTarget.toCurrency()}",
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Rp. ${wish.savingNominal.toCurrency()} / ${WishModel.savingPlanTimeName(wish.savingPlan).toLowerCase()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
            Text("${wish.getSavingPercentage().toStringAsFixed(0)}%",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
