import 'package:hive/hive.dart';

import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';

class MovieCacheDataSource {
  static const _moviesListBoxName = 'moviesListBox';
  static const _moviesListKeyName = 0;
  static const _movieDetailsBoxName = 'movieDetailsBox';
  static const _favoriteMoviesBoxName = 'favoriteMoviesBox';

  Future<void> upsertMoviesList(List<MovieSummaryCM> moviesList) =>
      Hive.openBox<List>(_moviesListBoxName)
          .then(
            (box) => box.put(_moviesListKeyName, moviesList),
          )
          .catchError(_printError);

  Future<List<MovieSummaryCM>> getMoviesList() =>
      Hive.openBox<List>(_moviesListBoxName)
          .then(
            (box) => box.get(_moviesListKeyName)?.cast<MovieSummaryCM>(),
          )
          .catchError(_printError);

  Future<void> upsertMovieDetails(MovieDetailsCM movieDetails) =>
      Hive.openBox<MovieDetailsCM>(_movieDetailsBoxName)
          .then(
            (box) => box.put(movieDetails.id, movieDetails),
          )
          .catchError(_printError);

  Future<MovieDetailsCM> getMovieDetails(int movieId) =>
      Hive.openBox<MovieDetailsCM>(_movieDetailsBoxName)
          .then(
            (box) => box.get(movieId),
          )
          .catchError(_printError);

  Future<void> upsertFavoriteMovie(int movieId) =>
      Hive.openBox<void>(_favoriteMoviesBoxName)
          .then(
            (box) => box.put(movieId, null),
          )
          .catchError(_printError);

  Future<void> deleteFavoriteMovie(int movieId) =>
      Hive.openBox<void>(_favoriteMoviesBoxName)
          .then(
            (box) => box.delete(movieId),
          )
          .catchError(_printError);

  Future<Set<int>> getFavoriteMovies() =>
      Hive.openBox<void>(_favoriteMoviesBoxName)
          .then(
            (box) => Set<int>.from(box.keys),
          )
          .catchError(_printError);

  Future<bool> isFavoriteMovie(int movieId) =>
      Hive.openBox<void>(_favoriteMoviesBoxName)
          .then(
            (box) => box.containsKey(movieId),
          )
          .catchError(_printError);

  // By default Hive was not printing errors, so this function was made to print
  // them
  void _printError(dynamic error) {
    print(error);
    throw error;
  }
}
