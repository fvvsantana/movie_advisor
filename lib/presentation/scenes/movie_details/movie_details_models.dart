import 'package:meta/meta.dart';

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
  final MovieDetailsVM movieDetails;
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

class FavoriteRaceConditionError implements FavoriteActionResult {}

class MovieDetailsVM {
  const MovieDetailsVM({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.synopsis,
    @required this.genres,
    @required this.isFavorite,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null),
        assert(synopsis != null),
        assert(genres != null),
        assert(isFavorite != null);

  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;
  final List<String> genres;
  final bool isFavorite;

  MovieDetailsVM copy({
    int id,
    String title,
    String imageUrl,
    String synopsis,
    List<String> genres,
    bool isFavorite,
  }) =>
      MovieDetailsVM(
        id: id ?? this.id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        synopsis: synopsis ?? this.synopsis,
        genres: genres ?? this.genres,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
