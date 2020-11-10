class RouteNameBuilder {
  static const String homeResource = '/';
  static const String moviesResource = 'movies';
  static const String moviesPathParameterId = 'id';

  static String moviesList() => moviesResource;

  static String movieById(int id) => '$moviesResource/$id';
}
