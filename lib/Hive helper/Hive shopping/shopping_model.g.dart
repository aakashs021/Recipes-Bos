// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingAdapter extends TypeAdapter<Shopping> {
  @override
  final int typeId = 3;

  @override
  Shopping read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shopping(
      id: fields[0] as String,
      shoppinlist: fields[1] as String,
      customcheckbox: fields[2] as bool,
      count: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Shopping obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.shoppinlist)
      ..writeByte(2)
      ..write(obj.customcheckbox)
      ..writeByte(3)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
