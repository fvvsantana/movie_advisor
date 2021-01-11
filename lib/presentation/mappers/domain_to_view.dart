import 'package:domain/models/movie_summary.dart';
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

