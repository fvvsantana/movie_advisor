import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/model/movie_summary.dart';

abstract class MoviesListResponseState {}

class Loading implements MoviesListResponseState {}

class Error implements MoviesListResponseState {
  const Error({@required this.error}) : assert(error != null);

  factory Error.fromObject({@required Object error}) {
    assert(error != null);
    return Error(
      error: error.toCustomError(),
    );
  }

  final CustomError error;
}

class Success implements MoviesListResponseState {
  const Success({@required this.moviesList}) : assert(moviesList != null);
  final List<MovieSummary> moviesList;
}
