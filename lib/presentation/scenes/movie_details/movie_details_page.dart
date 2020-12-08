import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/action_handler.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/popups.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_favorite_action_results.dart';
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
  final _focusDetectorKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailsBloc(movieId: widget.id);
  }

  @override
  Widget build(BuildContext context) => FocusDetector(
        onFocusGained: () => _bloc.onFocusGained.add(null),
        key: _focusDetectorKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).movieDetailsAppBarTitle),
          ),
          body: ActionHandler<FavoriteActionResult>(
            actionStream: _bloc.onNewFavoriteResult,
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
                successWidgetBuilder: (context, successState) =>
                    MovieDetailsContent(
                  movieDetails: successState.movieDetails,
                  onFavoriteButtonPressed: () =>
                      _bloc.onToggleFavorite.add(null),
                ),
              ),
            ),
          ),
        ),
      );

  void _handleFavoriteAction(FavoriteActionResult favoriteState) {
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
