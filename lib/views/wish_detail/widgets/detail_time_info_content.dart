import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/date_time_extension/date_time_extension.dart';
import 'package:flutter/material.dart';

class DetailTimeInfoContent extends StatelessWidget {
  final WishModel wish;
  const DetailTimeInfoContent({super.key, required this.wish});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dibuat", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(wish.createdAt.toFormattedDateString(useShortMonthName: true),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Tercapai",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "${wish.getEstimatedRemainingTime()} ${WishModel.savingPlanTimeName(wish.savingPlan)} Lagi",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
