import 'package:meta/meta.dart';

import 'package:domain/gateways/movie_repository.dart';
import 'package:domain/gateways/error_logger.dart';
import 'package:domain/models/movie_details.dart';
import 'package:domain/use_cases/use_case.dart';

class GetMovieDetailsUC extends UseCase<GetMovieDetailsUCParams, MovieDetails> {
  const GetMovieDetailsUC({
    @required this.repository,
    @required ErrorLoggerGateway logger,
  })  : assert(repository != null),
        assert(logger != null),
        super(logger: logger);

  final MovieRepositoryGateway repository;

  @override
  Future<MovieDetails> getRawFuture(
          {@required GetMovieDetailsUCParams params}) =>
      repository.getMovieDetails(params.movieId);
}

class GetMovieDetailsUCParams {
  const GetMovieDetailsUCParams({@required this.movieId})
      : assert(movieId != null);
  final int movieId;
}
