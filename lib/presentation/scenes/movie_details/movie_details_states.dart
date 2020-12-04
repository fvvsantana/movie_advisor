import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/model/movie_details.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState {}

class Error implements MovieDetailsResponseState {
  const Error({@required this.error}) : assert(error != null);
  final Object error;
}

class Success implements MovieDetailsResponseState {
  const Success({
    @required this.movieDetails,
  })  : assert(movieDetails != null);
  final MovieDetails movieDetails;
}
