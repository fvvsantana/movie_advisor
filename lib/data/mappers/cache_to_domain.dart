import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:movie_advisor/model/movie_details.dart';
import 'package:movie_advisor/model/movie_summary.dart';

extension MovieSummaryCMapper on MovieSummaryCM {
  MovieSummary toDomain() => MovieSummary(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
}

extension MovieDetailsCMapper on MovieDetailsCM {
  MovieDetails toDomain() => MovieDetails(
        id: id,
        title: title,
        imageUrl: imageUrl,
        synopsis: synopsis,
        genres: genres,
      );
}
