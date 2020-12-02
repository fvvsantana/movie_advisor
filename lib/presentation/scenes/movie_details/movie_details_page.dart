import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<MovieDetailsBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).movieDetailsAppBarTitle),
        ),
        body: StreamBuilder<MovieDetailsResponseState>(
          stream: _bloc.onNewState,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
            snapshot: snapshot,
            errorWidgetBuilder: (context, errorState) => ErrorEmptyState(
              error: errorState.error,
              onTryAgainTap: () => _bloc.onTryAgain.add(null),
            ),
            successWidgetBuilder: (context, successState) => MovieDetails(
              movieDetails: successState.movieDetails,
            ),
          ),
        ),
      );
}
