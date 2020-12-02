import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/data/models/movie_details_model.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';
import 'package:movie_advisor/data/remote/url_builder.dart';
import 'package:movie_advisor/common/errors.dart';

class MovieRemoteDataSource {
  const MovieRemoteDataSource({@required dio})
      : _dio = dio,
        assert(dio != null);
  final Dio _dio;

  void _throwCustomError(dynamic error) {
    stderr.write(error);
    // Treat errors
    if (error is DioError && error.type == DioErrorType.DEFAULT) {
      throw const NoInternetError();
    } else {
      throw GenericError.fromObject(object: error);
    }
  }

  Future<List<MovieSummaryModel>> getMoviesList() => _dio
          .get(
        UrlBuilder.getMoviesList(),
      )
          .then((response) {
        // Request successful at this point
        final data = List<Map<String, dynamic>>.from(response.data);
        return data
            .map(
              (movie) => MovieSummaryModel.fromJson(movie),
            )
            .toList();
      }).catchError(_throwCustomError);

  Future<MovieDetailsModel> getMovieDetails(int movieId) => _dio
      .get(
        UrlBuilder.getMovieDetails(movieId),
      )
      .then(
        (response) => MovieDetailsModel.fromJson(response.data),
      )
      .catchError(_throwCustomError);
}
