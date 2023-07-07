// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyModelAdapter extends TypeAdapter<MoneyModel> {
  @override
  final int typeId = 1;

  @override
  MoneyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyModel(
      IN: fields[3] as String,
      amount: fields[2] as String,
      datetime: fields[4] as DateTime,
      explain: fields[1] as String,
      name: fields[0] as String,
      id: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.explain)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.IN)
      ..writeByte(4)
      ..write(obj.datetime)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
