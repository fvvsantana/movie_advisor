import 'package:movie_advisor/data/cache/cache_data_source.dart';
import 'package:movie_advisor/data/remote/remote_data_source.dart';
import 'package:movie_advisor/model/movie_details.dart';
import 'package:movie_advisor/model/movie_summary.dart';
import 'package:movie_advisor/data/mappers/remote_to_cache.dart';
import 'package:movie_advisor/data/mappers/cache_to_domain.dart';

class Repository {
  final _remoteDS = MovieRemoteDataSource();
  final _cacheDS = MovieCacheDataSource();

  Future<List<MovieSummary>> getMoviesList() async {
    try {
      final remoteModelList = await _remoteDS.getMoviesList();

      final cacheModelList = remoteModelList
          .map(
            (remoteModel) => remoteModel.toCache(),
          )
          .toList();
      await _cacheDS.upsertMoviesList(cacheModelList);

      return cacheModelList
          .map(
            (cacheModel) => cacheModel.toDomain(),
          )
          .toList();
    } catch (_) {
      final cacheModelList = await _cacheDS.getMoviesList();
      if (cacheModelList != null) {
        return cacheModelList
            .map(
              (cacheModel) => cacheModel.toDomain(),
            )
            .toList();
      }

      rethrow;
    }
  }

  Future<MovieDetails> getMovieDetails(int movieId) async {
    final isFavorite = await isFavoriteMovie(movieId);

    try {
      final remoteModel = await _remoteDS.getMovieDetails(movieId);

      final cacheModel = remoteModel.toCache();
      await _cacheDS.upsertMovieDetails(cacheModel);

      return cacheModel.toDomain(isFavorite);
    } catch (_) {
      final cacheModel = await _cacheDS.getMovieDetails(movieId);
      if (cacheModel != null) {
        return cacheModel.toDomain(isFavorite);
      }

      rethrow;
    }
  }

  Future<List<MovieSummary>> getFavoriteMovies() async {
    final moviesList = await getMoviesList();
    final favoriteMovieIds = await _cacheDS.getFavoriteMovies();
    return moviesList
        .where(
          (movie) => favoriteMovieIds.contains(movie.id),
        )
        .toList();
  }

  Future<bool> isFavoriteMovie(int movieId) =>
      _cacheDS.isFavoriteMovie(movieId);

  /*
    The reason why this function receives the 'isFavorite' parameter, instead of
    just being a toggleFavoriteMovie() function, is because we want to execute
    the action based on the state that is in the Bloc, no the state of the
    database.
    In scenarios where we have multiple screens with the same favorite button
    for example, if you use toggleFavorite() in the repository, things can get
    messy.
    For instance, if you have two screens opened, and you hit the favorite
    button of the first screen, then the button of the second screen will have
    it's effect inverted. It will favorite when it's supposed to unfavorite, and
    vice-versa.
   */
  Future<void> setFavoriteMovie(int movieId, bool isFavorite) async =>
      isFavorite
          ? await _cacheDS.upsertFavoriteMovie(movieId)
          : await _cacheDS.deleteFavoriteMovie(movieId);
}
