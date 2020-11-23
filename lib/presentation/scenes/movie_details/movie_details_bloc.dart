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
        _onFavoriteSubject.stream.listen((isFavorite) {
          // TODO: treat errors of Hive
          if (isFavorite) {
            _repository.upsertFavoriteMovie(movieId);
          } else {
            _repository.deleteFavoriteMovie(movieId);
          }
        }),
      );
  }

  final int movieId;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onFavoriteSubject = StreamController<bool>();
  final _repository = Repository();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Sink<bool> get onFavorite => _onFavoriteSubject.sink;

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
  }
}
