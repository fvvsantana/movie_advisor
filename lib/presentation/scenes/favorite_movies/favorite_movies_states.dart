import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/model/movie_summary.dart';

abstract class FavoriteMoviesResponseState {}

class Loading implements FavoriteMoviesResponseState {}

class Error implements FavoriteMoviesResponseState {
  const Error({@required this.error}) : assert(error != null);
  final Object error;
}

class Success implements FavoriteMoviesResponseState {
  const Success({@required this.favoriteMovies})
      : assert(favoriteMovies != null);
  final List<MovieSummary> favoriteMovies;
}
