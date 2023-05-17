import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/utils/extension/duration_extension/duration_extension.dart';

extension AchievedExtension on WishModel {
  int durationToAchieve() {
    Duration duration = completedAt!.difference(createdAt);
    switch (savingPlan) {
      case SavingPlan.daily:
        return duration.inDays;
      case SavingPlan.weekly:
        return duration.inWeek;
      case SavingPlan.monthly:
        return duration.inMonth;
    }
  }
}
