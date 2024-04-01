// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnrecipeAdapter extends TypeAdapter<Ownrecipe> {
  @override
  final int typeId = 2;

  @override
  Ownrecipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ownrecipe(
      id: fields[0] as String,
      description: fields[2] as String?,
      foodname: fields[1] as String,
      file: (fields[3] as List?)?.cast<String>(),
      ingredients: (fields[4] as List?)?.cast<String>(),
      direction: (fields[5] as List?)?.cast<String>(),
      min: fields[7] as int?,
      hour: fields[6] as int?,
      uid: fields[9] as String?,
      datetime: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Ownrecipe obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodname)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.direction)
      ..writeByte(6)
      ..write(obj.hour)
      ..writeByte(7)
      ..write(obj.min)
      ..writeByte(8)
      ..write(obj.datetime)
      ..writeByte(9)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnrecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
