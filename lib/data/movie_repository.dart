import 'package:flutter/material.dart';
import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/model/movie_details.dart';
import 'package:movie_advisor/model/movie_summary.dart';
import 'package:movie_advisor/data/mappers/remote_to_cache.dart';
import 'package:movie_advisor/data/mappers/cache_to_domain.dart';

class MovieRepository {
  const MovieRepository({
    @required this.movieRDS,
    @required this.movieCDS,
  })  : assert(movieRDS != null),
        assert(movieCDS != null);

  final MovieRemoteDataSource movieRDS;
  final MovieCacheDataSource movieCDS;

  Future<List<MovieSummary>> getMoviesList() async {
    try {
      final remoteModelList = await movieRDS.getMoviesList();

      final cacheModelList = remoteModelList
          .map(
            (remoteModel) => remoteModel.toCache(),
          )
          .toList();
      await movieCDS.upsertMoviesList(cacheModelList);

      return cacheModelList
          .map(
            (cacheModel) => cacheModel.toDomain(),
          )
          .toList();
    } catch (_) {
      final cacheModelList = await movieCDS.getMoviesList();
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
    final isFavorite = await movieCDS.isFavoriteMovie(movieId);

    try {
      final remoteModel = await movieRDS.getMovieDetails(movieId);

      final cacheModel = remoteModel.toCache();
      await movieCDS.upsertMovieDetails(cacheModel);

      return cacheModel.toDomain(isFavorite);
    } catch (_) {
      final cacheModel = await movieCDS.getMovieDetails(movieId);
      if (cacheModel != null) {
        return cacheModel.toDomain(isFavorite);
      }

      rethrow;
    }
  }

  Future<List<MovieSummary>> getFavoriteMovies() async {
    final moviesList = await getMoviesList();
    final favoriteMovieIds = await movieCDS.getFavoriteMovies();
    return moviesList
        .where(
          (movie) => favoriteMovieIds.contains(movie.id),
        )
        .toList();
  }

  /*
    The reason why this function receives the 'isFavorite' parameter, instead of
    just being a toggleFavoriteMovie() function, is because we want to execute
    the action based on the state of the ui, not based on the state of the
    database. There is no guarantee that both states are the same all the time.
   */
  Future<void> setFavoriteMovie(int movieId, bool isFavorite) async =>
      isFavorite
          ? await movieCDS.upsertFavoriteMovie(movieId)
          : await movieCDS.deleteFavoriteMovie(movieId);
}
