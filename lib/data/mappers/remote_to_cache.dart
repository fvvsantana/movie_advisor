import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';
import 'package:movie_advisor/data/remote/models/movie_summary_rm.dart';

extension MovieSummaryRMapper on MovieSummaryRM {
  MovieSummaryCM toCache() => MovieSummaryCM(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
}

extension MovieDetailsRMapper on MovieDetailsRM {
  MovieDetailsCM toCache() => MovieDetailsCM(
        id: id,
        title: title,
        imageUrl: imageUrl,
        synopsis: synopsis,
        genres: genres,
      );
}
