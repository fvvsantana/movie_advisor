import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_bloc.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
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
        handlerFunc: (context, params) => Provider<MoviesListBloc>(
          create: (context) => MoviesListBloc(
            remoteDS:
                Provider.of<MovieRemoteDataSource>(context, listen: false),
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: MoviesListPage(),
        ),
      ),
    )
    ..define(
      '${_Constants.moviesResource}/:${_Constants.moviesPathParameterId}',
      handler: Handler(
        handlerFunc: (context, params) => Provider<MovieDetailsBloc>(
          create: (context) => MovieDetailsBloc(
            remoteDS:
                Provider.of<MovieRemoteDataSource>(context, listen: false),
            movieId: int.parse(params[_Constants.moviesPathParameterId][0]),
          ),
          dispose: (_, bloc) => bloc.dispose(),
          child: MovieDetailsPage(),
        ),
      ),
    );
}

class RouteNameBuilder {
  static String home() => _Constants.homeResource;

  static String moviesList() => _Constants.moviesResource;

  static String movieById(int id) => '${_Constants.moviesResource}/$id';
}

class _Constants {
  static const String homeResource = '/';
  static const String moviesResource = 'movies';
  static const String moviesPathParameterId = 'id';
}
