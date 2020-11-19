import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/model/movie_summary.dart';

abstract class FavoriteMoviesResponseState {}

class Loading implements FavoriteMoviesResponseState {}

class Error implements FavoriteMoviesResponseState {
  const Error({@required this.error}) : assert(error != null);

  factory Error.fromObject({@required Object error}) {
    assert(error != null);
    return Error(
      error: error.toCustomError(),
    );
  }

  final CustomError error;
}

class Success implements FavoriteMoviesResponseState {
  const Success({@required this.moviesList}) : assert(moviesList != null);
  final List<MovieSummary> moviesList;
}
