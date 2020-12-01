import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/action_handler.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/popups.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/favorite_states.dart';
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
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailsBloc(movieId: widget.id);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).movieDetailsAppBarTitle),
        ),
        body: ActionHandler<FavoriteResponseState>(
          actionStream: _bloc.onNewFavoriteState,
          onReceived: _handleFavoriteAction,
          child: StreamBuilder<MovieDetailsResponseState>(
            stream: _bloc.onNewState,
            builder: (context, snapshot) =>
                AsyncSnapshotResponseView<Loading, Error, Success>(
              snapshot: snapshot,
              errorWidgetBuilder: (context, errorState) => ErrorEmptyState(
                error: errorState.error,
                onTryAgainTap: () => _bloc.onTryAgain.add(null),
              ),
              successWidgetBuilder: (context, successState) {
                final movieDetails = successState.movieDetails;
                final favoriting = !movieDetails.isFavorite;
                return MovieDetailsContent(
                  movieDetails: movieDetails,
                  onFavoriteButtonPressed: () =>
                      _bloc.onSetFavorite.add(favoriting),
                );
              },
            ),
          ),
        ),
      );

  void _handleFavoriteAction(FavoriteResponseState favoriteState) {
    if (favoriteState == null) {
      return;
    }

    String message;
    if (favoriteState is FavoriteError) {
      message = favoriteState.favoriting
          ? S.of(context).movieDetailsAddToFavoritesErrorMessage
          : S.of(context).movieDetailsRemoveFromFavoritesErrorMessage;
    } else if (favoriteState is FavoriteSuccess) {
      message = favoriteState.favoriting
          ? S.of(context).movieDetailsAddToFavoritesSuccessMessage
          : S.of(context).movieDetailsRemoveFromFavoritesSuccessMessage;
    }

    showSnackBar(context, message);
  }
}
