import 'package:dio/dio.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
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
];

final List<SingleChildWidget> dependentProviders = [];
