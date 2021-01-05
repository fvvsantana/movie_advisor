import 'package:dio/dio.dart';
import 'package:domain/use_cases/get_favorite_movies_uc.dart';
import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:domain/gateways/error_logger.dart';
import 'package:domain/gateways/movie_repository.dart';
import 'package:domain/use_cases/get_movies_list_uc.dart';
import 'package:domain/use_cases/get_movie_details_uc.dart';
import 'package:domain/use_cases/set_favorite_movie_uc.dart';
import 'package:movie_advisor/common/error_logger.dart';
import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/movie_repository.dart';
import 'package:movie_advisor/data/cache/hive_settings.dart';
import 'package:movie_advisor/presentation/routing.dart';

final List<SingleChildWidget> globalProviders = [
  ..._routingProviders,
  ..._loggerProviders,
  ..._rdsProviders,
  ..._cdsProviders,
  ..._repositoryProviders,
  ..._useCaseProviders,
];

final List<SingleChildWidget> _routingProviders = [
  Provider<FluroRouter>(
    create: (_) => _buildFluroRouter(),
  ),
];

final List<SingleChildWidget> _loggerProviders = [
  Provider<ErrorLoggerGateway>(
    create: (_) => ErrorLogger(),
  ),
];

final List<SingleChildWidget> _rdsProviders = [
  Provider<Dio>(
    create: (_) => Dio(),
  ),
  ProxyProvider<Dio, MovieRemoteDataSource>(
    update: (_, dio, rds) =>
        rds ??
        MovieRemoteDataSource(
          dio: dio,
        ),
  ),
];

final List<SingleChildWidget> _cdsProviders = [
  Provider<HiveInterface>(
    create: (_) => _buildHive(),
  ),
  ProxyProvider<HiveInterface, MovieCacheDataSource>(
    update: (_, hive, cds) =>
        cds ??
        MovieCacheDataSource(
          hive: hive,
        ),
  ),
];

final List<SingleChildWidget> _repositoryProviders = [
  ProxyProvider2<MovieRemoteDataSource, MovieCacheDataSource,
      MovieRepositoryGateway>(
    update: (_, rds, cds, repository) =>
        repository ?? MovieRepository(movieRDS: rds, movieCDS: cds),
  ),
];

final List<SingleChildWidget> _useCaseProviders = [
  ProxyProvider2<MovieRepositoryGateway, ErrorLoggerGateway, GetMoviesListUC>(
    update: (_, repository, logger, useCase) =>
        useCase ??
        GetMoviesListUC(
          repository: repository,
          logger: logger,
        ),
  ),
  ProxyProvider2<MovieRepositoryGateway, ErrorLoggerGateway, GetMovieDetailsUC>(
    update: (_, repository, logger, useCase) =>
        useCase ??
        GetMovieDetailsUC(
          repository: repository,
          logger: logger,
        ),
  ),
  ProxyProvider2<MovieRepositoryGateway, ErrorLoggerGateway,
      SetFavoriteMovieUC>(
    update: (_, repository, logger, useCase) =>
        useCase ??
        SetFavoriteMovieUC(
          repository: repository,
          logger: logger,
        ),
  ),
  ProxyProvider2<MovieRepositoryGateway, ErrorLoggerGateway,
      GetFavoriteMoviesUC>(
    update: (_, repository, logger, useCase) =>
        useCase ??
        GetFavoriteMoviesUC(
          repository: repository,
          logger: logger,
        ),
  ),
];

FluroRouter _buildFluroRouter() {
  final router = FluroRouter.appRouter;
  defineRoutes(router);
  return router;
}

HiveInterface _buildHive() {
  final hive = Hive;
  initHive(hive);
  return hive;
}
