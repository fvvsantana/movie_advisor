import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_summary_rm.g.dart';

@JsonSerializable(nullable: false)
class MovieSummaryRM {
  const MovieSummaryRM({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null);

  factory MovieSummaryRM.fromJson(Map<String, dynamic> json) =>
      _$MovieSummaryRMFromJson(json);
  Map<String, dynamic> toJson() => _$MovieSummaryRMToJson(this);

  final int id;
  final String title;
  @JsonKey(name: 'poster_url')
  final String imageUrl;

}
