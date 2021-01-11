import 'package:domain/models/movie_details.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_models.dart';

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
