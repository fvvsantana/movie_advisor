import 'package:flutter/foundation.dart';

class MovieDetails {
  const MovieDetails({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.synopsis,
    @required this.genres,
    @required this.isFavorite,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null),
        assert(synopsis != null),
        assert(genres != null),
        assert(isFavorite != null);

  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;
  final List<String> genres;
  final bool isFavorite;

  MovieDetails copy({
    int id,
    String title,
    String imageUrl,
    String synopsis,
    List<String> genres,
    bool isFavorite,
  }) =>
      MovieDetails(
        id: id ?? this.id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        synopsis: synopsis ?? this.synopsis,
        genres: genres ?? this.genres,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
