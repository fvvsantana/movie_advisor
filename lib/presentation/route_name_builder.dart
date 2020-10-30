class RouteNameBuilder{
  static const String moviesResource = 'movies';
  static String moviesList() => moviesResource;
  static String movieById(int id) => '$moviesResource/$id';
}