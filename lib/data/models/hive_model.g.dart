// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelAdapter extends TypeAdapter<HiveModel> {
  @override
  final int typeId = 0;

  @override
  HiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModel()
      ..productName = fields[0] as String
      ..material1 = fields[1] as int
      ..material2 = fields[2] as int
      ..material3 = fields[3] as int
      ..material4 = fields[4] as int
      ..isSynced = fields[5] as bool
      ..id = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, HiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.material1)
      ..writeByte(2)
      ..write(obj.material2)
      ..writeByte(3)
      ..write(obj.material3)
      ..writeByte(4)
      ..write(obj.material4)
      ..writeByte(5)
      ..write(obj.isSynced)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
