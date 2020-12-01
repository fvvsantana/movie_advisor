import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/repository.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_favorite_states.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsBloc {
  MovieDetailsBloc({@required this.movieId}) : assert(movieId != null) {
    _subscriptions
      ..add(
        _fetchMovieDetails().listen(_onNewStateSubject.add),
      )
      ..add(
        _onTryAgainSubject.stream
            .flatMap(
              (_) => _fetchMovieDetails(),
            )
            .listen(_onNewStateSubject.add),
      )
      ..add(
        _onSetFavorite.stream
            .flatMap(_setFavorite)
            .listen(_onNewFavoriteStateSubject.add),
      );
  }

  final int movieId;
  final _repository = Repository();

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onNewFavoriteStateSubject = BehaviorSubject<FavoriteResponseState>();
  final _onSetFavorite = StreamController<bool>();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<FavoriteResponseState> get onNewFavoriteState =>
      _onNewFavoriteStateSubject.stream;

  Sink<bool> get onSetFavorite => _onSetFavorite.sink;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: await _repository.getMovieDetails(movieId),
      );
    } catch (error) {
      yield Error.fromObject(error: error);
    }
  }

  /*
    The reason why this function receives the 'favoriting' parameter, instead of
    just being a _toggleFavorite() function, is because we want to execute the
    action based on what is on the screen of the user.
    In scenarios where we have multiple screens with the same favorite button,
    if you use _toggleFavorite(), things can get messy. For example, if you have
    two screens opened, and you hit the favorite button of the first screen, the
    button of the second screen will have it's effect inverted. It will favorite
    when it's supposed to unfavorite, and vice-versa.
   */
  Stream<FavoriteResponseState> _setFavorite(bool favoriting) async* {
    final lastState = _onNewStateSubject.value;
    if (lastState is Success) {
      final movieDetails = lastState.movieDetails;

      try {
        await _repository.setFavoriteMovie(movieId, favoriting);
        // Update the UI
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
    _onNewFavoriteStateSubject.close();
    _onSetFavorite.close();
  }
}
