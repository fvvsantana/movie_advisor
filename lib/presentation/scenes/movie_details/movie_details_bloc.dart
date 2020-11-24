import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_advisor/data/repository.dart';
import 'package:rxdart/rxdart.dart';

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
        _onFavoriteSubject.stream.listen((isFavorite) async {
          if (isFavorite) {
            try {
              await _repository.upsertFavoriteMovie(movieId);
              _onFavoritingErrorSubject.sink.add(false);
            } catch (_) {
              _onFavoritingErrorSubject.sink.add(true);
            }
          } else {
            try {
              await _repository.deleteFavoriteMovie(movieId);
              _onUnfavoritingErrorSubject.sink.add(false);
            } catch (_) {
              _onUnfavoritingErrorSubject.sink.add(true);
            }
          }
        }),
      );
  }

  final int movieId;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onFavoriteSubject = StreamController<bool>();
  final _onFavoritingErrorSubject = StreamController<bool>();
  final _onUnfavoritingErrorSubject = StreamController<bool>();
  final _repository = Repository();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Sink<bool> get onFavorite => _onFavoriteSubject.sink;

  Stream<bool> get onFavoritingError => _onFavoritingErrorSubject.stream;

  Stream<bool> get onUnfavoritingError => _onUnfavoritingErrorSubject.stream;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: await _repository.getMovieDetails(movieId),
        isFavorite: await _repository.isFavoriteMovie(movieId),
      );
    } catch (error) {
      yield Error.fromObject(error: error);
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
    _onFavoriteSubject.close();
    _onFavoritingErrorSubject.close();
    _onUnfavoritingErrorSubject.close();
  }
}
