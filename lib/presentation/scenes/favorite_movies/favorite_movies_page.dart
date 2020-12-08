import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/movies_list.dart';
import 'package:movie_advisor/presentation/common/retry_empty_state.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_bloc.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';

class FavoriteMoviesPage extends StatefulWidget {
  @override
  _FavoriteMoviesPageState createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  final _bloc = FavoriteMoviesBloc();
  final _focusDetectorKey = UniqueKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).favoriteMoviesAppBarTitle),
        ),
        body: FocusDetector(
          onFocusGained: () => _bloc.onTryAgain.add(null),
          key: _focusDetectorKey,
          child: StreamBuilder<FavoriteMoviesResponseState>(
            stream: _bloc.onNewState,
            builder: (context, snapshot) =>
                AsyncSnapshotResponseView<Loading, Error, Success>(
              snapshot: snapshot,
              errorWidgetBuilder: (context, errorState) => ErrorEmptyState(
                error: errorState.error,
                onTryAgainTap: onTryAgain,
              ),
              successWidgetBuilder: (context, successState) {
                final favoriteMovies = successState.favoriteMovies;
                return favoriteMovies.isEmpty
                    ? RetryEmptyState(
                        message: S.of(context).favoriteMoviesEmptyStateMessage,
                        onRetry: onTryAgain,
                      )
                    : MoviesList(
                        movies: favoriteMovies,
                        onMovieTap: _pushMovieDetails,
                      );
              },
            ),
          ),
        ),
      );

  void onTryAgain() => _bloc.onTryAgain.add(null);

  void _pushMovieDetails(int movieId) {
    Navigator.of(context).pushNamed(
      RouteNameBuilder.movieById(movieId),
    );
  }
}
