import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/achieved_extension.dart';
import 'package:celenganku/utils/extension/date_time_extension/date_time_extension.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:flutter/material.dart';

class AchievedDetailInfo extends StatelessWidget {
  final WishModel wish;
  const AchievedDetailInfo({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 28.0,
      ),
      child: Column(
        children: [
          Text(
            "Rp. ${wish.savingTarget.toCurrency()}",
            style: const TextStyle(
              fontSize: 28.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "Tercapai Dalam Waktu ${wish.durationToAchieve()} ${WishModel.savingPlanTimeName(wish.savingPlan)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const Divider(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tanggal Dibuat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                wish.createdAt.toFormattedDateString(useShortMonthName: true),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tercapai",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                wish.completedAt!
                    .toFormattedDateString(useShortMonthName: true),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
