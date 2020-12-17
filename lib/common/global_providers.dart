import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/repository.dart';

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
  ProxyProvider2<MovieRemoteDataSource, MovieCacheDataSource, Repository>(
    update: (_, rds, cds, repository) =>
        repository ?? Repository(movieRDS: rds, movieCDS: cds),
  ),
];

FluroRouter _buildFluroRouter() {
  defineRoutes();
  return FluroRouter.appRouter;
}

HiveInterface _buildHive() {
  WidgetsFlutterBinding.ensureInitialized();

  getApplicationDocumentsDirectory().then((dir) {
    Hive
      ..init(dir.path)
      ..registerAdapter<MovieSummaryCM>(
        MovieSummaryCMAdapter(),
      )
      ..registerAdapter<MovieDetailsCM>(
        MovieDetailsCMAdapter(),
      );
  });

  return Hive;
}
