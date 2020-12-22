import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:movie_advisor/data/cache/hive_settings.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/movie_repository.dart';

final List<SingleChildWidget> globalProviders = [
  ..._routingProviders,
  ..._rdsProviders,
  ..._cdsProviders,
  ..._repositoryProviders,
];

final List<SingleChildWidget> _routingProviders = [
  Provider<FluroRouter>(
    create: (_) => _buildFluroRouter(),
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
  ProxyProvider2<MovieRemoteDataSource, MovieCacheDataSource, MovieRepository>(
    update: (_, rds, cds, repository) =>
        repository ?? MovieRepository(movieRDS: rds, movieCDS: cds),
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
