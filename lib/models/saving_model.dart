import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saving_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class SavingModel extends Equatable {
  const SavingModel({
    required this.savingNominal,
    required this.createdAt,
    required this.message,
  });

  @HiveField(0)
  final int savingNominal;
  @HiveField(1)
  final DateTime createdAt;
  @HiveField(2)
  final String message;

  SavingModel copyWith({
    int? savingNominal,
    DateTime? createdAt,
    String? message,
  }) {
    return SavingModel(
      savingNominal: savingNominal ?? this.savingNominal,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
    );
  }

  factory SavingModel.fromJson(Map<String, dynamic> json) =>
      _$SavingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavingModelToJson(this);

  @override
  List<Object?> get props => [savingNominal, createdAt, message];
}
