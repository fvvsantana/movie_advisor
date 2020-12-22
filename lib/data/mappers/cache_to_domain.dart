import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:domain/models/movie_details.dart';
import 'package:domain/models/movie_summary.dart';

extension MovieSummaryCMMapper on MovieSummaryCM {
  MovieSummary toDomain() => MovieSummary(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
}

extension MovieDetailsCMMapper on MovieDetailsCM {
  MovieDetails toDomain(bool isFavorite) => MovieDetails(
        id: id,
        title: title,
        imageUrl: imageUrl,
        synopsis: synopsis,
        genres: genres,
        isFavorite: isFavorite,
      );
}
