import 'package:meta/meta.dart';

import 'package:domain/data/movie_repository.dart';
import 'package:domain/error_logger.dart';
import 'package:domain/use_cases/use_case.dart';

class SetFavoriteMovieUC extends UseCase<SetFavoriteMovieUCParams, void> {
  const SetFavoriteMovieUC({
    @required this.repository,
    @required ErrorLoggerGateway logger,
  })  : assert(repository != null),
        assert(logger != null),
        super(logger: logger);

  final MovieRepositoryGateway repository;

  @override
  Future<void> getRawFuture(
          {@required SetFavoriteMovieUCParams params}) =>
      repository.setFavoriteMovie(params.movieId, params.isFavorite);
}

class SetFavoriteMovieUCParams {
  const SetFavoriteMovieUCParams({
    @required this.movieId,
    @required this.isFavorite,
  })  : assert(movieId != null),
        assert(isFavorite != null);
  final int movieId;
  final bool isFavorite;
}
