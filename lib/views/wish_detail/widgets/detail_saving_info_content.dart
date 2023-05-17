import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:flutter/material.dart';

class DetailSavingInfoContent extends StatelessWidget {
  final WishModel wish;
  const DetailSavingInfoContent({
    super.key,
    required this.wish,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text("Terkumpul",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                "Rp. ${wish.getTotalSaving().toCurrency()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
          width: 15,
          child: VerticalDivider(),
        ),
        Expanded(
          child: Column(
            children: [
              const Text("Kurang",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(
                "Rp. ${(wish.savingTarget - wish.getTotalSaving()).toCurrency()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
