import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/movies_list.dart';
import 'package:movie_advisor/presentation/route_name_builder.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_bloc.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';

class FavoriteMoviesPage extends StatefulWidget {
  @override
  _FavoriteMoviesPageState createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  final _bloc = FavoriteMoviesBloc();

  void _pushMovieDetails(int movieId) {
    Navigator.of(context).pushNamed(
      RouteNameBuilder.movieById(movieId),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).favoriteMoviesAppBarTitle),
        ),
        body: StreamBuilder<FavoriteMoviesResponseState>(
          stream: _bloc.onNewState,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
                  snapshot: snapshot,
                  errorWidgetBuilder: (context, errorState) => ErrorEmptyState(
                        error: errorState.error,
                        onTryAgainTap: () => _bloc.onTryAgain.add(null),
                      ),
                  successWidgetBuilder: (context, successState) {
                    final favoriteMovies = successState.favoriteMovies;
                    if (favoriteMovies.isEmpty) {
                      return FavoriteMoviesEmptyState();
                    }
                    return MoviesList(
                      movies: successState.favoriteMovies,
                      onMovieTap: _pushMovieDetails,
                    );
                  }),
        ),
      );
}
