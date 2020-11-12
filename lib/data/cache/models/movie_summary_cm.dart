import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'movie_summary_cm.g.dart';


@HiveType(typeId: 0)
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