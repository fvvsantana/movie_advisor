import 'package:domain/models/movie_details.dart';
import 'package:domain/models/movie_summary.dart';
import 'package:movie_advisor/presentation/models/movie_details_vm.dart';
import 'package:movie_advisor/presentation/models/movie_summary_vm.dart';

extension MovieSummaryDMMapper on MovieSummary {
  MovieSummaryVM toView() => MovieSummaryVM(
        id: id,
        title: title,
        imageUrl: imageUrl,
      );
}

extension MovieSummaryDMListMapper on List<MovieSummary> {
  List<MovieSummaryVM> toView() => map(
        (movie) => movie.toView(),
      ).toList();
}

extension MovieDetailsDMMapper on MovieDetails {
  MovieDetailsVM toView() => MovieDetailsVM(
        id: id,
        title: title,
        imageUrl: imageUrl,
        synopsis: synopsis,
        genres: genres,
        isFavorite: isFavorite,
      );
}

extension MovieDetailsDMListMapper on List<MovieDetails> {
  List<MovieDetailsVM> toView() => map(
        (details) => details.toView(),
      ).toList();
}
