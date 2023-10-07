// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoricModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoricModelAdapter extends TypeAdapter<HistoricModel> {
  @override
  final int typeId = 1;

  @override
  HistoricModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoricModel()
      ..nome = fields[1] as String
      ..altura = fields[2] as double
      ..peso = fields[3] as double
      ..imc = fields[4] as double
      ..situacao = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, HistoricModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.altura)
      ..writeByte(3)
      ..write(obj.peso)
      ..writeByte(4)
      ..write(obj.imc)
      ..writeByte(5)
      ..write(obj.situacao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoricModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
