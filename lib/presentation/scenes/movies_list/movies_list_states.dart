import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/models/movie_summary_rm.dart';

abstract class MoviesListResponseState {}

class Loading implements MoviesListResponseState {}

class Error implements MoviesListResponseState {
  const Error({@required this.error}) : assert(error != null);

  factory Error.fromObject({@required Object error}) {
    assert(error != null);
    return Error(
      error:
          error is CustomError ? error : GenericError.fromObject(object: error),
    );
  }

  final CustomError error;
}

class Success implements MoviesListResponseState {
  const Success({@required this.moviesList}) : assert(moviesList != null);
  final List<MovieSummaryRM> moviesList;
}
