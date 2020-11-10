import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/models/movie_details_model.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState{}

class Error implements MovieDetailsResponseState {
  const Error({@required this.error}) : assert(error != null);
  final CustomError error;
}

class Success implements MovieDetailsResponseState {
  const Success({@required this.movieDetails}) : assert(movieDetails != null);
  final MovieDetailsModel movieDetails;
}
