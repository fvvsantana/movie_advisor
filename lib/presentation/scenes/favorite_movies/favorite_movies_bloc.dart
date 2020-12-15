import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/repository.dart';

class FavoriteMoviesBloc {
  FavoriteMoviesBloc({@required this.repository}): assert(repository != null) {
    _subscriptions
      ..add(
        _onFocusGainedSubject.stream.listen(_onTryAgainSubject.add),
      )
      ..add(
        _onTryAgainSubject.stream
            .flatMap(
              (_) => _fetchFavoriteMovies(),
            )
            .listen(_onNewStateSubject.add),
      );
  }

  final Repository repository;
  
  final _subscriptions = CompositeSubscription();
  final _onFocusGainedSubject = StreamController<void>();
  final _onNewStateSubject = BehaviorSubject<FavoriteMoviesResponseState>();
  final _onTryAgainSubject = StreamController<void>();

  Sink<void> get onFocusGained => _onFocusGainedSubject.sink;

  Stream<FavoriteMoviesResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<FavoriteMoviesResponseState> _fetchFavoriteMovies() async* {
    yield Loading();

    try {
      yield Success(
        favoriteMovies: await repository.getFavoriteMovies(),
      );
    } catch (error) {
      yield Error(error: error);
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onFocusGainedSubject.close();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
  }
}
