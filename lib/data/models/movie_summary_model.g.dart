// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSummaryModel _$MovieSummaryModelFromJson(Map<String, dynamic> json) {
  return MovieSummaryModel(
    id: json['id'] as int,
    title: json['title'] as String,
    imageUrl: json['poster_url'] as String,
  );
}

Map<String, dynamic> _$MovieSummaryModelToJson(MovieSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_url': instance.imageUrl,
    };
