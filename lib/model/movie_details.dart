import 'package:flutter/foundation.dart';

class MovieDetails {
  const MovieDetails({
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

  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;
  final List<String> genres;
}
