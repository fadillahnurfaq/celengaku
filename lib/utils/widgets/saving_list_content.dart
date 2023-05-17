import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/utils/extension/date_time_extension/date_time_extension.dart';
import 'package:celenganku/utils/extension/num_extension/num_extension.dart';
import 'package:flutter/material.dart';

class SavingListContent extends StatelessWidget {
  final SavingModel saving;
  final bool firstIndex;
  const SavingListContent({
    super.key,
    required this.saving,
    required this.firstIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool isNegative = saving.savingNominal <= 0;
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${saving.createdAt.toFormattedDateString()} • ${saving.createdAt.toFormattedTimeString()}", // date
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(saving.message),
                ),
                Text(
                  "${isNegative ? '' : '+'} ${saving.savingNominal.toCurrency()}", // saving nominalaving nominal
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isNegative ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ), // mes
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        if (firstIndex == false) const Divider(height: 1),
      ],
    );
  }
}
