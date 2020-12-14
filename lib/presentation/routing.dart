import 'package:fluro/fluro.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_page.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

void defineRoutes() {
  FluroRouter.appRouter
    ..define(
      _homeResource,
      handler: Handler(
        handlerFunc: (context, params) => HomeScreen(),
      ),
    )
    ..define(
      _moviesResource,
      handler: Handler(
        handlerFunc: (context, params) => MoviesListPage(),
      ),
    )
    ..define(
      '$_moviesResource/:$_moviesPathParameterId',
      handler: Handler(
        handlerFunc: (context, params) => MovieDetailsPage(
          id: int.parse(params[_moviesPathParameterId][0]),
        ),
      ),
    )
    ..define(
      _favoritesResource,
      handler: Handler(
        handlerFunc: (context, params) => FavoriteMoviesPage(),
      ),
    );
}

class RouteNameBuilder {
  static String home() => _homeResource;

  static String moviesList() => _moviesResource;

  static String movieById(int id) => '$_moviesResource/$id';

  static String favoritesList() => _favoritesResource;
}

const _homeResource = '/';
const _moviesResource = 'movies';
const _moviesPathParameterId = 'id';
const _favoritesResource = 'favorites';
