import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movie_advisor/data/cache/models/hive_type_ids.dart';

part 'movie_details_cm.g.dart';


@HiveType(typeId: HiveTypeId.movieDetails)
class MovieDetailsCM {
  const MovieDetailsCM({
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

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final String synopsis;
  @HiveField(4)
  final List<String> genres;
}
