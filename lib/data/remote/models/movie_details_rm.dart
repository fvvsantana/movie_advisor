import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_rm.g.dart';

@JsonSerializable(nullable: false)
class MovieDetailsRM {
  const MovieDetailsRM({
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

  factory MovieDetailsRM.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsRMFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsRMToJson(this);

  final int id;
  final String title;
  @JsonKey(name: 'poster_url')
  final String imageUrl;
  @JsonKey(name: 'overview')
  final String synopsis;
  final List<String> genres;
}
