import 'package:hive/hive.dart';

import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';

class CacheDataSource {
  static const _moviesListBoxName = 'moviesListBox';
  static const _moviesListKeyName = 'moviesListKey';
  static const _movieDetailsBoxName = 'movieDetailsBox';
  static const _favoriteMoviesBoxName = 'favoriteMoviesBox';

  // By default Hive was not printing errors, so I made this function to print
  // them
  void _printError(dynamic error) {
    print(error);
    throw error;
  }

  // Hive always stores lists as List<dynamic> in the persistent memory, it
  // won't change, even if you pass List<MovieSummaryCM> to the openBox method.
  Future<void> upsertMoviesList(List<MovieSummaryCM> moviesList) =>
      Hive.openBox<List>(_moviesListBoxName)
          .then(
            (box) => box.put(_moviesListKeyName, moviesList),
          )
          .catchError(_printError);

  Future<List<MovieSummaryCM>> getMoviesList() {
    /*
      You will get an error if you try to pass the type List<MovieSummaryCM> to
      the method openBox.
      This happens because internally the Hive will try to cast the stored
      List<dynamic> to List<MovieSummaryCM> using the 'as' keyword, which won't
      work.
      This happens in the file box_impl.dart, in the method:
        E get(dynamic key, {E defaultValue}) {
          ...
            return frame.value as E;
          ...
        }
      Where frame.value is the stored data and has type List<dynamic>, and E is
      the type passed to the openBox method.
     */
    final boxFuture = Hive.openBox<List>(_moviesListBoxName);

    return boxFuture
        .then<List<MovieSummaryCM>>(
          (box) => box.get(_moviesListKeyName)?.cast<MovieSummaryCM>(),
        )
        .catchError(_printError);
  }

  Future<void> upsertMovieDetails(MovieDetailsCM movieDetails) =>
      Hive.openBox<MovieDetailsCM>(_movieDetailsBoxName)
          .then(
            (box) => box.put(movieDetails.id, movieDetails),
          )
          .catchError(_printError);

  Future<MovieDetailsCM> getMovieDetails(int movieId) =>
      Hive.openBox<MovieDetailsCM>(_movieDetailsBoxName)
          .then<MovieDetailsCM>(
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
}
