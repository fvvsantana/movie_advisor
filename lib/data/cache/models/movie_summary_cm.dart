import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movie_advisor/data/cache/models/hive_type_ids.dart';

part 'movie_summary_cm.g.dart';


@HiveType(typeId: HiveTypeId.movieSummary)
class MovieSummaryCM{
  const MovieSummaryCM({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null);


  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
}