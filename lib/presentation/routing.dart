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
        handlerFunc: (context, params) =>
            ProxyProvider<Repository, MoviesListBloc>(
          update: (_, repository, bloc) =>
              bloc ??
              MoviesListBloc(
                repository: repository,
              ),
          dispose: (_, bloc) => bloc.dispose(),
          child: MoviesListPage(),
        ),
      ),
    )
    ..define(
      '$_moviesResource/:$_moviesPathParameterId',
      handler: Handler(
        handlerFunc: (context, params) =>
            ProxyProvider<Repository, MovieDetailsBloc>(
          update: (_, repository, bloc) =>
              bloc ??
              MovieDetailsBloc(
                repository: repository,
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
        handlerFunc: (context, params) =>
            ProxyProvider<Repository, FavoriteMoviesBloc>(
          update: (_, repository, bloc) =>
              bloc ??
              FavoriteMoviesBloc(
                repository: repository,
              ),
          dispose: (_, bloc) => bloc.dispose(),
          child: Consumer<FavoriteMoviesBloc>(
            builder: (_, bloc, __) => FavoriteMoviesPage(
              bloc: bloc,
            ),
          ),
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
