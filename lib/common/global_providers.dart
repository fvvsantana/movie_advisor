import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/repository.dart';

final List<SingleChildWidget> globalProviders = [
  ..._rdsProviders,
  ..._cdsProviders,
  ..._repositoryProviders,
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
    create: (_) => Hive,
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
