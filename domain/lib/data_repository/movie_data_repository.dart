import 'package:domain/models/movie_details.dart';
import 'package:domain/models/movie_summary.dart';

abstract class MovieDataRepository {
  const MovieDataRepository();

  Future<List<MovieSummary>> getMovieSummaryList();

  Future<MovieDetails> getMovie(int id);

  Future<void> favoriteMovie(int movieId);

  Future<void> unfavoriteMovie(int movieId);
}
