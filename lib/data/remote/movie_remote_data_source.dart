import 'package:dio/dio.dart';
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

  Future<List<Map<String, dynamic>>> getMoviesList() => _dio
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
        return List<Map<String, dynamic>>.from(response.data);
      });

  Future<Map<String, dynamic>> getMovieDetails(int movieId) => _dio
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
        return response.data;
      });
}
