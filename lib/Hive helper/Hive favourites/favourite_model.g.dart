// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteAdapter extends TypeAdapter<Favourite> {
  @override
  final int typeId = 1;

  @override
  Favourite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourite(
      id: fields[0] as String,
      foodname: fields[1] as String,
      file: (fields[2] as List).cast<String>(),
      description: fields[3] as String,
      ingredients: (fields[4] as List).cast<String>(),
      direction: (fields[5] as List).cast<String>(),
      hour: fields[6] as int,
      date: fields[8] as DateTime,
      min: fields[7] as int,
      uid: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Favourite obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.foodname)
      ..writeByte(2)
      ..write(obj.file)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.direction)
      ..writeByte(6)
      ..write(obj.hour)
      ..writeByte(7)
      ..write(obj.min)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
