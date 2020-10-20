import 'package:dio/dio.dart';
import 'package:movie_advisor/data/models/movie_details_model.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';
import 'package:movie_advisor/data/remote/url_builder.dart';
import 'package:movie_advisor/common/errors.dart';

class MovieRemoteDataSource {
  final _dio = Dio();

  void _throwCustomError(dynamic error) {
    print(error);
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
          .catchError(_throwCustomError)
          .then((response) {
        // Treat more server errors
        if (response.data == null) {
          throw const ServerResponseError();
        }
        // Request successful at this point
        final data = List<Map<String, dynamic>>.from(response.data);
        return data
            .map(
              (movie) => MovieSummaryModel.fromJson(movie),
            )
            .toList();
      });

  Future<MovieDetailsModel> getMovieDetails(int movieId) => _dio
          .get(
            UrlBuilder.getMovieDetails(movieId),
          )
          .catchError(_throwCustomError)
          .then((response) {
        // Treat more server errors
        if (response.data == null) {
          throw const ServerResponseError();
        }
        // Request successful at this point
        //return Map<String,dynamic>.from(response.data);
        final data = response.data;
        return MovieDetailsModel(
            id: data['id'],
            title: data['title'],
            imageUrl: data['poster_url'],
            synopsis: data['overview'],
            genres: List<String>.from(data['genres']));
      });
}
