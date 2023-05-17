// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingModelAdapter extends TypeAdapter<SavingModel> {
  @override
  final int typeId = 2;

  @override
  SavingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingModel(
      savingNominal: fields[0] as int,
      createdAt: fields[1] as DateTime,
      message: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavingModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.savingNominal)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingModel _$SavingModelFromJson(Map<String, dynamic> json) => SavingModel(
      savingNominal: json['savingNominal'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      message: json['message'] as String,
    );

Map<String, dynamic> _$SavingModelToJson(SavingModel instance) =>
    <String, dynamic>{
      'savingNominal': instance.savingNominal,
      'createdAt': instance.createdAt.toIso8601String(),
      'message': instance.message,
    };
