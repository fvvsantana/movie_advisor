// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) {
  return MovieDetailsModel(
    id: json['id'] as int,
    title: json['title'] as String,
    imageUrl: json['poster_url'] as String,
    synopsis: json['overview'] as String,
    genres: (json['genres'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_url': instance.imageUrl,
      'overview': instance.synopsis,
      'genres': instance.genres,
    };
