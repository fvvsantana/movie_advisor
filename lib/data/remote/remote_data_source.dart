import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';
import 'package:movie_advisor/data/remote/models/movie_summary_rm.dart';
import 'package:movie_advisor/data/remote/url_builder.dart';
import 'package:movie_advisor/common/errors.dart';

class RemoteDataSource {
  final _dio = Dio();

  void _throwCustomError(dynamic error) {
    stderr.write(error);
    // Treat errors
    if (error is DioError && error.type == DioErrorType.DEFAULT) {
      throw const NoInternetError();
    } else {
      throw GenericError.fromObject(object: error);
    }
  }

  Future<List<MovieSummaryRM>> getMoviesList() => _dio
          .get(
        UrlBuilder.getMoviesList(),
      )
          .then((response) {
        // Request successful at this point
        final data = List<Map<String, dynamic>>.from(response.data);
        return data
            .map(
              (movie) => MovieSummaryRM.fromJson(movie),
            )
            .toList();
      }).catchError(_throwCustomError);

  Future<MovieDetailsRM> getMovieDetails(int movieId) => _dio
      .get(
        UrlBuilder.getMovieDetails(movieId),
      )
      .then(
        (response) => MovieDetailsRM.fromJson(response.data),
      )
      .catchError(_throwCustomError);
}
