import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/model/movie_summary.dart';

abstract class MoviesListResponseState {}

class Loading implements MoviesListResponseState {}

class Error implements MoviesListResponseState {
  const Error({@required this.error}) : assert(error != null);
  final dynamic error;
}

class Success implements MoviesListResponseState {
  const Success({@required this.moviesList}) : assert(moviesList != null);
  final List<MovieSummary> moviesList;
}
