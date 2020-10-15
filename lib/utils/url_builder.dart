class UrlBuilder{
  static const _moviesBaseUrl = 'https://desafio-mobile.nyc3.digitaloceanspaces.com';

  static String getMoviesList() => '$_moviesBaseUrl/movies';
  static String getMovieDetails(int movieId) => '$_moviesBaseUrl/movies/$movieId';
}