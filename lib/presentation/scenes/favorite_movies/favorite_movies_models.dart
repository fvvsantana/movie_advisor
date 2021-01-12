import 'package:domain/models/movie_summary.dart';
import 'package:meta/meta.dart';

abstract class FavoriteMoviesResponseState {}

class Loading implements FavoriteMoviesResponseState {}

class Error implements FavoriteMoviesResponseState {
  const Error({@required this.error}) : assert(error != null);
  final dynamic error;
}

class Success implements FavoriteMoviesResponseState {
  const Success({@required this.favoriteMovies})
      : assert(favoriteMovies != null);
  final List<MovieSummary> favoriteMovies;
}

