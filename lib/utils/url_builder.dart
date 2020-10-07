class UrlBuilder{
  static const _moviesBaseUrl = 'https://desafio-mobile.nyc3.digitaloceanspaces.com';

  static String moviesList() => '$_moviesBaseUrl/movies';
  static String movieDetails(int movieId) => '$_moviesBaseUrl/movies/$movieId';
}