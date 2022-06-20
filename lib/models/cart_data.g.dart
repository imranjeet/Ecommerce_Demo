// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDataAdapter extends TypeAdapter<CartData> {
  @override
  final int typeId = 0;

  @override
  CartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartData(
      id: fields[0] as int,
      title: fields[1] as String,
      quantity: fields[2] as int,
      price: fields[3] as int,
      size: fields[4] as String,
      color: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
