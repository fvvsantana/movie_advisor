import 'package:domain/models/movie_details.dart';
import 'package:domain/models/movie_summary.dart';

abstract class MovieRepositoryGateway {
  Future<List<MovieSummary>> getMoviesList();

  Future<MovieDetails> getMovieDetails(int movieId);

  Future<List<MovieSummary>> getFavoriteMovies();

  Future<void> setFavoriteMovie(int movieId, bool isFavorite);
}
