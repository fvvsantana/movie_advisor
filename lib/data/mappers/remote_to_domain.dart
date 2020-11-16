import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';
import 'package:movie_advisor/data/remote/models/movie_summary_rm.dart';
import 'package:movie_advisor/model/movie_details.dart';
import 'package:movie_advisor/model/movie_summary.dart';

extension MovieSummaryRMapper on MovieSummaryRM {
  MovieSummary toDomain() => MovieSummary(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
}

extension MovieDetailsRMapper on MovieDetailsRM {
  MovieDetails toDomain() => MovieDetails(
        id: id,
        title: title,
        imageUrl: imageUrl,
        synopsis: synopsis,
        genres: genres,
      );
}
