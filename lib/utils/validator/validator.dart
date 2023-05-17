import 'package:celenganku/models/wish_model.dart';

class Validator {
  static String? required(
    dynamic value,
    String message, {
    String? fieldName,
  }) {
    if (value is String || value == null) {
      if (value.toString() == "null") return message;
      if (value.isEmpty) return message;
    }
    return null;
  }

  static String? nominal(
    dynamic value,
    String savingTarget,
    SavingPlan savingPlan,
    String message, {
    String? fieldName,
  }) {
    if (value is String || value == null) {
      if (value.toString() == "null") return message;
      if (value.isEmpty) return message;
      if (savingTarget.isNotEmpty) {
        if (int.parse(value.toString().replaceAll(".", "")) >=
            int.parse(savingTarget.replaceAll(".", ""))) {
          return "Target per ${WishModel.savingPlanTimeName(savingPlan).toLowerCase()} harus kurang dari target tabungan";
        }
      }
    }
    return null;
  }
}
