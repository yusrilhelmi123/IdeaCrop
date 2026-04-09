// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeaModelAdapter extends TypeAdapter<IdeaModel> {
  @override
  final int typeId = 0;

  @override
  IdeaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdeaModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      reference: fields[3] as String?,
      tags: (fields[4] as List).cast<String>(),
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      isFavorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IdeaModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reference)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
