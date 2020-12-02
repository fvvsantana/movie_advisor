import 'package:movie_advisor/data/cache/cache_data_source.dart';
import 'package:movie_advisor/data/remote/remote_data_source.dart';
import 'package:movie_advisor/model/movie_details.dart';
import 'package:movie_advisor/model/movie_summary.dart';
import 'package:movie_advisor/data/mappers/remote_to_cache.dart';
import 'package:movie_advisor/data/mappers/cache_to_domain.dart';

class Repository {
  final _remoteDS = RemoteDataSource();
  final _cacheDS = CacheDataSource();

  // Try to get movies list from remote data source.
  // Use cache as fallback for network errors.
  Future<List<MovieSummary>> getMoviesList() async {
    // Make request
    try {
      // Fetch movies list from network
      final moviesListR = await _remoteDS.getMoviesList();

      // Remote to cache
      final moviesListC = moviesListR
          .map(
            (remoteModel) => remoteModel.toCache(),
          )
          .toList();
      // Update cache
      await _cacheDS.upsertMoviesList(moviesListC);

      // Cache to domain
      return moviesListC
          .map(
            (cacheModel) => cacheModel.toDomain(),
          )
          .toList();
    } catch (error) {
      final moviesListC = await _cacheDS.getMoviesList();
      // Cache-hit check
      if (moviesListC != null) {
        return moviesListC
            .map(
              (remoteModel) => remoteModel.toDomain(),
            )
            .toList();
      }

      // Cache-miss
      rethrow;
    }
  }

  // Try to get movie details from remote data source.
  // Use cache as fallback for network errors.
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final isFavorite = await isFavoriteMovie(movieId);

    // Make request
    try {
      // Fetch movies list from network
      final movieDetailsR = await _remoteDS.getMovieDetails(movieId);

      // Remote to cache
      final movieDetailsC = movieDetailsR.toCache();
      // Update cache
      await _cacheDS.upsertMovieDetails(movieDetailsC);

      // Cache to domain
      return movieDetailsC.toDomain(isFavorite);
    } catch (error) {
      final movieDetailsC = await _cacheDS.getMovieDetails(movieId);
      // Cache-hit check
      if (movieDetailsC != null) {
        return movieDetailsC.toDomain(isFavorite);
      }

      // Cache-miss
      rethrow;
    }
  }

  Future<void> upsertFavoriteMovie(int movieId) =>
      _cacheDS.upsertFavoriteMovie(movieId);

  Future<void> deleteFavoriteMovie(int movieId) =>
      _cacheDS.deleteFavoriteMovie(movieId);

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
          ? await upsertFavoriteMovie(movieId)
          : await deleteFavoriteMovie(movieId);
}
