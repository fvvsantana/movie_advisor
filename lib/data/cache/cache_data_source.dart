import 'package:hive/hive.dart';

import 'models/movie_summary_cm.dart';

class CacheDataSource {
  static const _moviesListBoxName = 'moviesListBox';
  static const _moviesListKeyName = 'moviesListKey';


  // Hive always stores lists as List<dynamic> in the persistent memory, it
  // won't change, even if you pass List<MovieSummaryCM> to the openBox method.
  Future<void> upsertMoviesList(List<MovieSummaryCM> moviesList) =>
      Hive.openBox<List>(_moviesListBoxName).then(
        (box) => box.put(_moviesListKeyName, moviesList),
      );

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

    return boxFuture.then<List<MovieSummaryCM>>(
      (box) => box.get(_moviesListKeyName)?.cast<MovieSummaryCM>(),
    );
  }
}
