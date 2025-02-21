// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logo_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogoModelHiveAdapter extends TypeAdapter<LogoModelHive> {
  @override
  final int typeId = 0;

  @override
  LogoModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogoModelHive(
      id: fields[0] as String,
      title: fields[1] as String,
      desc: fields[2] as String,
      priority: fields[3] as String,
      status: fields[4] as String,
      user: fields[5] as String,
      createdAt: fields[6] as String,
      updatedAt: fields[7] as String,
      image: fields[8] as String,
      userId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogoModelHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.user)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogoModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
