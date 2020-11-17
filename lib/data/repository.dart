import 'package:movie_advisor/data/cache/cache_data_source.dart';
import 'package:movie_advisor/data/remote/remote_data_source.dart';
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
}
