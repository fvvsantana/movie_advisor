import 'package:domain/gateways/error_logger.dart';
import 'package:meta/meta.dart';

import 'package:domain/gateways/movie_repository.dart';
import 'package:domain/models/movie_summary.dart';
import 'package:domain/use_cases/use_case.dart';

class GetFavoriteMoviesUC extends UseCase<void, List<MovieSummary>> {
  const GetFavoriteMoviesUC({
    @required this.repository,
    @required ErrorLoggerGateway logger,
  })  : assert(repository != null),
        assert(logger != null),
        super(logger: logger);

  final MovieRepositoryGateway repository;

  @override
  Future<List<MovieSummary>> getRawFuture({void params}) =>
      repository.getFavoriteMovies();
}
