import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:domain/use_cases/get_movie_details_uc.dart';
import 'package:domain/use_cases/set_favorite_movie_uc.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_models.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_mappers.dart';

class MovieDetailsBloc {
  MovieDetailsBloc({
    @required this.movieId,
    @required this.getMovieDetailsUC,
    @required this.setFavoriteMovieUC,
  })  : assert(movieId != null),
        assert(getMovieDetailsUC != null),
        assert(setFavoriteMovieUC != null) {
    _subscriptions
      ..add(
        _onFocusGainedSubject.stream.listen(_onTryAgainSubject.add),
      )
      ..add(
        _onTryAgainSubject.stream
            .flatMap(
              (_) => _fetchMovieDetails(),
            )
            .listen(_onNewStateSubject.add),
      )
      ..add(
        _onToggleFavoriteSubject.stream
            .flatMap((_) => _toggleFavorite())
            .listen(_onNewFavoriteResultSubject.add),
      );
  }

  final int movieId;
  final GetMovieDetailsUC getMovieDetailsUC;
  final SetFavoriteMovieUC setFavoriteMovieUC;

  final _subscriptions = CompositeSubscription();
  final _onFocusGainedSubject = StreamController<void>();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onNewFavoriteResultSubject = BehaviorSubject<FavoriteActionResult>();
  final _onToggleFavoriteSubject = StreamController<bool>();

  Sink<void> get onFocusGained => _onFocusGainedSubject.sink;

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<FavoriteActionResult> get onNewFavoriteResult =>
      _onNewFavoriteResultSubject.stream;

  Sink<void> get onToggleFavorite => _onToggleFavoriteSubject.sink;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: (await getMovieDetailsUC.getFuture(
          params: GetMovieDetailsUCParams(movieId: movieId),
        ))
            .toVM(),
      );
    } catch (error) {
      yield Error(error: error);
    }
  }

  Stream<FavoriteActionResult> _toggleFavorite() async* {
    final lastState = _onNewStateSubject.value;
    if (lastState is Success) {
      final movieDetails = lastState.movieDetails;
      final newIsFavorite = !movieDetails.isFavorite;

      try {
        await setFavoriteMovieUC.getFuture(
          params: SetFavoriteMovieUCParams(
            movieId: movieId,
            isFavorite: newIsFavorite,
          ),
        );
        _onNewStateSubject.sink.add(
          Success(
            movieDetails: movieDetails.copy(isFavorite: newIsFavorite),
          ),
        );
        yield FavoriteSuccess(newIsFavorite: newIsFavorite);
      } catch (_) {
        yield FavoriteError(newIsFavorite: newIsFavorite);
      }
    } else {
      yield FavoriteRaceConditionError();
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onFocusGainedSubject.close();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
    _onNewFavoriteResultSubject.close();
    _onToggleFavoriteSubject.close();
  }
}
