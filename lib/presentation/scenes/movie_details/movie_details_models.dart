import 'package:meta/meta.dart';

import 'package:domain/models/movie_details.dart';

abstract class MovieDetailsResponseState {}

class Loading implements MovieDetailsResponseState {}

class Error implements MovieDetailsResponseState {
  const Error({@required this.error}) : assert(error != null);
  final dynamic error;
}

class Success implements MovieDetailsResponseState {
  const Success({
    @required this.movieDetails,
  }) : assert(movieDetails != null);
  final MovieDetails movieDetails;
}

abstract class FavoriteActionResult {}

class FavoriteError implements FavoriteActionResult {
  const FavoriteError({@required this.newIsFavorite})
      : assert(newIsFavorite != null);
  final bool newIsFavorite;
}

class FavoriteSuccess implements FavoriteActionResult {
  const FavoriteSuccess({@required this.newIsFavorite})
      : assert(newIsFavorite != null);
  final bool newIsFavorite;
}
