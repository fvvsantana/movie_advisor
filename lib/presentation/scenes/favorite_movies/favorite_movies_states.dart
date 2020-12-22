import 'package:flutter/cupertino.dart';

import 'package:movie_advisor/presentation/models/movie_summary_vm.dart';

abstract class FavoriteMoviesResponseState {}

class Loading implements FavoriteMoviesResponseState {}

class Error implements FavoriteMoviesResponseState {
  const Error({@required this.error}) : assert(error != null);
  final dynamic error;
}

class Success implements FavoriteMoviesResponseState {
  const Success({@required this.favoriteMovies})
      : assert(favoriteMovies != null);
  final List<MovieSummaryVM> favoriteMovies;
}
