import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focus_detector/focus_detector.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/action_handler.dart';
import 'package:movie_advisor/presentation/common/async_snapshot_response_view.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/common/popups.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_bloc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_content.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_favorite_action_results.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsBloc _bloc;
  final _focusDetectorKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<MovieDetailsBloc>(context, listen: false);
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
    String message;
    if (favoriteState is FavoriteError) {
      message = favoriteState.newIsFavorite
          ? S.of(context).movieDetailsAddToFavoritesErrorMessage
          : S.of(context).movieDetailsRemoveFromFavoritesErrorMessage;
    } else if (favoriteState is FavoriteSuccess) {
      message = favoriteState.newIsFavorite
          ? S.of(context).movieDetailsAddToFavoritesSuccessMessage
          : S.of(context).movieDetailsRemoveFromFavoritesSuccessMessage;
    }else if(favoriteState is FavoriteRaceConditionError){
      message = S.of(context).movieDetailsGenericFavoriteErrorMessage;
    }

    showSnackBar(context, message);
  }
}
