import 'package:fluro/fluro.dart';
import 'package:movie_advisor/data/repository.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_bloc.dart';
import 'package:provider/provider.dart';

import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_page.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_bloc.dart';
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
        handlerFunc: (context, params) => Provider<MoviesListBloc>(
          create: (context) => MoviesListBloc(
            repository: Provider.of<Repository>(context, listen: false),
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: MoviesListPage(),
        ),
      ),
    )
    ..define(
      '$_moviesResource/:$_moviesPathParameterId',
      handler: Handler(
        handlerFunc: (context, params) => Provider<MovieDetailsBloc>(
          create: (context) => MovieDetailsBloc(
            repository: Provider.of<Repository>(context, listen: false),
            movieId: int.parse(params[_moviesPathParameterId][0]),
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: MovieDetailsPage(),
        ),
      ),
    )
    ..define(
      _favoritesResource,
      handler: Handler(
        handlerFunc: (context, params) => Provider<FavoriteMoviesBloc>(
          create: (context) => FavoriteMoviesBloc(
            repository: Provider.of<Repository>(context, listen: false),
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: FavoriteMoviesPage(),
        ),
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
