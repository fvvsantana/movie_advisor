import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/movie_repository.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_favorite_action_results.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';
import 'package:movie_advisor/presentation/mappers/domain_to_view.dart';

class MovieDetailsBloc {
  MovieDetailsBloc({
    @required this.repository,
    @required this.movieId,
  })  : assert(repository != null),
        assert(movieId != null) {
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
  final MovieRepository repository;

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
        movieDetails: (await repository.getMovieDetails(movieId)).toView(),
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
        await repository.setFavoriteMovie(movieId, newIsFavorite);
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
