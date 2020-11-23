import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_content.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({
    @required this.id,
  }) : assert(id != null);

  final int id;

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailsBloc(movieId: widget.id);
  }

  void onFavoriteButtonPressed(BuildContext context, bool isFavorite) {
    _bloc.onFavorite.add(isFavorite);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        // TODO: translate this text
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
      ),
    );
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
            successWidgetBuilder: (context, successState) =>
                MovieDetailsContent(
              movieDetails: successState.movieDetails,
              onFavoriteButtonPressed: (isFavorite) =>
                  onFavoriteButtonPressed(context, isFavorite),
            ),
          ),
        ),
      );
}
