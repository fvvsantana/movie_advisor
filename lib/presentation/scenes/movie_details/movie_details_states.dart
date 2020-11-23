import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/model/movie_details.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState {}

class Error implements MovieDetailsResponseState {
  const Error({@required this.error}) : assert(error != null);

  factory Error.fromObject({@required Object error}) {
    assert(error != null);
    return Error(
      error: error.toCustomError(),
    );
  }

  final CustomError error;
}

class Success implements MovieDetailsResponseState {
  const Success({
    @required this.movieDetails,
    @required this.isFavorite,
  })  : assert(movieDetails != null),
        assert(isFavorite != null);
  final MovieDetails movieDetails;
  final bool isFavorite;
}
