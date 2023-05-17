import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:celenganku/models/saving_model.dart';

part 'wish_model.g.dart';

@HiveType(typeId: 1)
enum SavingPlan {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  monthly,
}

@HiveType(typeId: 0)
@JsonSerializable()
class WishModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int savingTarget;
  @HiveField(3)
  final SavingPlan savingPlan;
  @HiveField(4)
  final int savingNominal;
  @HiveField(5)
  final List<SavingModel> listSaving;
  @HiveField(6)
  final DateTime createdAt;
  @HiveField(7)
  final DateTime? completedAt;
  @HiveField(8)
  final String? imagePath;
  const WishModel({
    required this.id,
    required this.name,
    required this.savingTarget,
    required this.savingPlan,
    required this.savingNominal,
    required this.listSaving,
    required this.createdAt,
    this.completedAt,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        savingTarget,
        savingPlan,
        savingNominal,
        listSaving,
        createdAt,
        completedAt,
        imagePath,
      ];

  WishModel copyWith({
    String? id,
    String? name,
    int? savingTarget,
    SavingPlan? savingPlan,
    int? savingNominal,
    List<SavingModel>? listSaving,
    DateTime? createdAt,
    DateTime? completedAt,
    String? imagePath,
  }) {
    return WishModel(
      id: id ?? this.id,
      name: name ?? this.name,
      savingTarget: savingTarget ?? this.savingTarget,
      savingPlan: savingPlan ?? this.savingPlan,
      savingNominal: savingNominal ?? this.savingNominal,
      listSaving: listSaving ?? this.listSaving,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  factory WishModel.fromJson(Map<String, dynamic> json) =>
      _$WishModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishModelToJson(this);

  static String savingPlanTimeName(SavingPlan savingPlan) {
    switch (savingPlan) {
      case SavingPlan.daily:
        return 'Hari';
      case SavingPlan.weekly:
        return 'Minggu';
      case SavingPlan.monthly:
        return 'Bulan';
    }
  }

  int getTotalSaving() {
    if (listSaving.isEmpty) return 0;
    return listSaving
        .map((e) => e.savingNominal)
        .toList()
        .reduce((value1, value2) => value1 + value2);
  }

  double getSavingPercentage() {
    return (getTotalSaving() / savingTarget) * 100;
  }

  int getEstimatedRemainingTime() {
    return ((savingTarget - getTotalSaving()) / savingNominal).ceil();
  }

  @override
  bool get stringify => true;
}
