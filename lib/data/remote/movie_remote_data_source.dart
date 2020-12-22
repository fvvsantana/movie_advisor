import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:domain/entities/errors.dart';
import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';
import 'package:movie_advisor/data/remote/models/movie_summary_rm.dart';
import 'package:movie_advisor/data/remote/url_builder.dart';

class MovieRemoteDataSource {
  const MovieRemoteDataSource({@required this.dio}) : assert(dio != null);
  final Dio dio;

  Future<List<MovieSummaryRM>> getMoviesList() => dio
          .get(
        UrlBuilder.getMoviesList(),
      )
          .then((response) {
        final data = List<Map<String, dynamic>>.from(response.data);
        return data
            .map(
              (movie) => MovieSummaryRM.fromJson(movie),
            )
            .toList();
      }).catchError(_treatError);

  Future<MovieDetailsRM> getMovieDetails(int movieId) => dio
      .get(
        UrlBuilder.getMovieDetails(movieId),
      )
      .then(
        (response) => MovieDetailsRM.fromJson(response.data),
      )
      .catchError(_treatError);

  void _treatError(dynamic error) {
    print(error);

    if (error is DioError && error.type == DioErrorType.DEFAULT) {
      throw const NoInternetError();
    } else {
      throw error;
    }
  }
}
