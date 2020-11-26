import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/movies_list.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final _bloc = MoviesListBloc();

  void _pushMovieDetails(int movieId) {
    Navigator.of(context).pushNamed(
      RouteNameBuilder.movieById(movieId),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).moviesListAppBarTitle),
        ),
        body: StreamBuilder<MoviesListResponseState>(
          stream: _bloc.onNewState,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
            snapshot: snapshot,
            errorWidgetBuilder: (context, errorState) => ErrorEmptyState(
              error: errorState.error,
              onTryAgainTap: () => _bloc.onTryAgain.add(null),
            ),
            successWidgetBuilder: (context, successState) {
              final moviesList = successState.moviesList;
              if (moviesList.isEmpty) {
                return MoviesListEmptyState();
              }
              return MoviesList(
                movies: successState.moviesList,
                onMovieTap: _pushMovieDetails,
              );
            },
          ),
        ),
      );
}
