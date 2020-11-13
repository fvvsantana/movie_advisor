import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState {}

class Error implements MovieDetailsResponseState {
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

class Success implements MovieDetailsResponseState {
  const Success({@required this.movieDetails}) : assert(movieDetails != null);
  final MovieDetailsRM movieDetails;
}
