import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie_summary_model.g.dart';

@JsonSerializable(nullable: false)
class MovieSummaryModel {
  const MovieSummaryModel({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null);

  factory MovieSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MovieSummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieSummaryModelToJson(this);

  final int id;
  final String title;
  @JsonKey(name: 'poster_url')
  final String imageUrl;

}
