import 'package:flutter/material.dart';

import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final _bloc = MoviesListBloc();

  void _pushMovieDetails(Object routeArguments) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MovieDetailsPage(),
        settings: RouteSettings(arguments: routeArguments),
      ),
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
            errorWidgetBuilder: (context, errorState) =>
                ErrorEmptyState.fromError(
              error: errorState.error,
              onTryAgainTap: () {},
            ),
            successWidgetBuilder: (context, successState) => MoviesList(
              movies: successState.moviesList,
              onMovieTap: _pushMovieDetails,
            ),
          ),
        ),
      );
}
