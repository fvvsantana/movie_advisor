import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/repository.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_favorite_action_results.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsBloc {
  MovieDetailsBloc({@required this.movieId}) : assert(movieId != null) {
    _subscriptions
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
  final _repository = Repository();

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onNewFavoriteResultSubject = BehaviorSubject<FavoriteActionResult>();
  final _onToggleFavoriteSubject = StreamController<bool>();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<FavoriteActionResult> get onNewFavoriteResult =>
      _onNewFavoriteResultSubject.stream;

  Sink<void> get onToggleFavorite => _onToggleFavoriteSubject.sink;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: await _repository.getMovieDetails(movieId),
      );
    } catch (error) {
      yield Error(error: error);
    }
  }

  Stream<FavoriteActionResult> _toggleFavorite() async* {
    final lastState = _onNewStateSubject.value;
    if (lastState is Success) {
      final movieDetails = lastState.movieDetails;
      final favoriting = !movieDetails.isFavorite;

      try {
        await _repository.setFavoriteMovie(movieId, favoriting);
        _onNewStateSubject.sink.add(
          Success(
            movieDetails: movieDetails.copy(isFavorite: favoriting),
          ),
        );
        yield FavoriteSuccess(favoriting: favoriting);
      } catch (_) {
        yield FavoriteError(favoriting: favoriting);
      }
    } else {
      yield null;
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
    _onNewFavoriteResultSubject.close();
    _onToggleFavoriteSubject.close();
  }
}
