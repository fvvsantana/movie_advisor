import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';

abstract class MoviesListResponseState {}

class Loading implements MoviesListResponseState{}

class Error implements MoviesListResponseState {
  const Error({@required this.error}) : assert(error != null);
  final CustomError error;
}

class Success implements MoviesListResponseState {
  const Success({@required this.moviesList}) : assert(moviesList != null);
  final List<MovieSummaryModel> moviesList;
}
