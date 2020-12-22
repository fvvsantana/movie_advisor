import 'package:flutter/cupertino.dart';
import 'package:movie_advisor/presentation/models/movie_details_vm.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState {}

class Error implements MovieDetailsResponseState {
  const Error({@required this.error}) : assert(error != null);
  final dynamic error;
}

class Success implements MovieDetailsResponseState {
  const Success({
    @required this.movieDetails,
  })  : assert(movieDetails != null);
  final MovieDetailsVM movieDetails;
}
