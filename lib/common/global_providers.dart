import 'package:dio/dio.dart';
import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> globalProviders = [
  ...independentProviders,
  ...dependentProviders,
];

final List<SingleChildWidget> independentProviders = [
  Provider<MovieRemoteDataSource>(
    create: (_) => MovieRemoteDataSource(
      dio: Dio(),
    ),
  ),
  Provider<MovieCacheDataSource>(
    create: (_) => MovieCacheDataSource(),
  ),
];

final List<SingleChildWidget> dependentProviders = [
  ProxyProvider2<MovieRemoteDataSource, MovieCacheDataSource, Repository>(
    update: (_, rds, cds, repository) =>
        Repository(movieRDS: rds, movieCDS: cds),
  ),
];
