// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsCMAdapter extends TypeAdapter<MovieDetailsCM> {
  @override
  final int typeId = 1;

  @override
  MovieDetailsCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsCM(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      synopsis: fields[3] as String,
      genres: (fields[4] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsCM obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.synopsis)
      ..writeByte(4)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
