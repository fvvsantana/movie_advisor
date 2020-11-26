import 'package:fluro/fluro.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_page.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

void defineRoutes() {
  FluroRouter.appRouter
    ..define(
      _Constants.homeResource,
      handler: Handler(
        handlerFunc: (context, params) => HomeScreen(),
      ),
    )
    ..define(
      _Constants.moviesResource,
      handler: Handler(
        handlerFunc: (context, params) => MoviesListPage(),
      ),
    )
    ..define(
      '${_Constants.moviesResource}/:${_Constants.moviesPathParameterId}',
      handler: Handler(
        handlerFunc: (context, params) => MovieDetailsPage(
          id: int.parse(params[_Constants.moviesPathParameterId][0]),
        ),
      ),
    )
    ..define(
      _Constants.favoritesResource,
      handler: Handler(
        handlerFunc: (context, params) => FavoriteMoviesPage(),
      ),
    );
}

class RouteNameBuilder {
  static String home() => _Constants.homeResource;

  static String moviesList() => _Constants.moviesResource;

  static String movieById(int id) => '${_Constants.moviesResource}/$id';

  static String favoritesList() => _Constants.favoritesResource;
}

class _Constants {
  static const String homeResource = '/';
  static const String moviesResource = 'movies';
  static const String moviesPathParameterId = 'id';
  static const String favoritesResource = 'favorites';
}
