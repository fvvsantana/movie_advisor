import 'package:hive/hive.dart';

import 'models/movie_summary_cm.dart';

class CacheDataSource {
  static const _moviesListBoxName = 'moviesListBox';
  static const _moviesListKeyName = 'moviesListKey';

  Future<void> upsertMoviesList(List<MovieSummaryCM> moviesList) =>
      Hive.openBox<List<MovieSummaryCM>>(_moviesListBoxName).then(
        (box) => box.put(_moviesListKeyName, moviesList),
      );

  Future<List<MovieSummaryCM>> getMoviesList() =>
      Hive.openBox<List<MovieSummaryCM>>(_moviesListBoxName).then(
        (box) => box.get(_moviesListKeyName),
      );
}
