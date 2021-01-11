import 'package:flutter/material.dart';

import 'package:domain/models/movie_details.dart';
import 'package:domain/models/movie_summary.dart';
import 'package:domain/data/movie_repository.dart';
import 'package:movie_advisor/data/cache/movie_cache_data_source.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/data/mappers/remote_to_cache.dart';
import 'package:movie_advisor/data/mappers/cache_to_domain.dart';

class MovieRepository implements MovieRepositoryGateway {
  const MovieRepository({
    @required this.movieRDS,
    @required this.movieCDS,
  })  : assert(movieRDS != null),
        assert(movieCDS != null);

  final MovieRemoteDataSource movieRDS;
  final MovieCacheDataSource movieCDS;

  @override
  Future<List<MovieSummary>> getMoviesList() async {
    try {
      final remoteModelList = await movieRDS.getMoviesList();

      final cacheModelList = remoteModelList
          .map(
            (remoteModel) => remoteModel.toCM(),
          )
          .toList();
      await movieCDS.upsertMoviesList(cacheModelList);

      return cacheModelList
          .map(
            (cacheModel) => cacheModel.toDM(),
          )
          .toList();
    } catch (_) {
      final cacheModelList = await movieCDS.getMoviesList();
      if (cacheModelList != null) {
        return cacheModelList
            .map(
              (cacheModel) => cacheModel.toDM(),
            )
            .toList();
      }

      rethrow;
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final isFavorite = await movieCDS.isFavoriteMovie(movieId);

    try {
      final remoteModel = await movieRDS.getMovieDetails(movieId);

      final cacheModel = remoteModel.toCM();
      await movieCDS.upsertMovieDetails(cacheModel);

      return cacheModel.toDM(isFavorite);
    } catch (_) {
      final cacheModel = await movieCDS.getMovieDetails(movieId);
      if (cacheModel != null) {
        return cacheModel.toDM(isFavorite);
      }

      rethrow;
    }
  }

  @override
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
  @override
  Future<void> setFavoriteMovie(int movieId, bool isFavorite) async =>
      isFavorite
          ? await movieCDS.upsertFavoriteMovie(movieId)
          : await movieCDS.deleteFavoriteMovie(movieId);
}
