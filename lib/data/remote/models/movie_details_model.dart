import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_model.g.dart';

@JsonSerializable(nullable: false)
class MovieDetailsModel {
  const MovieDetailsModel({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.synopsis,
    @required this.genres,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null),
        assert(synopsis != null),
        assert(genres != null);

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);

  final int id;
  final String title;
  @JsonKey(name: 'poster_url')
  final String imageUrl;
  @JsonKey(name: 'overview')
  final String synopsis;
  final List<String> genres;
}
