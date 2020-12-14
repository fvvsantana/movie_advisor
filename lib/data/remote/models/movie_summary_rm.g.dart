// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSummaryRM _$MovieSummaryRMFromJson(Map<String, dynamic> json) {
  return MovieSummaryRM(
    id: json['id'] as int,
    title: json['title'] as String,
    imageUrl: json['poster_url'] as String,
  );
}

Map<String, dynamic> _$MovieSummaryRMToJson(MovieSummaryRM instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_url': instance.imageUrl,
    };
