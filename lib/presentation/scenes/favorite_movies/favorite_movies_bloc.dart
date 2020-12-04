import 'dart:async';

import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/repository.dart';

class FavoriteMoviesBloc {
  FavoriteMoviesBloc() {
    _subscriptions
      ..add(
        _fetchFavoriteMovies().listen(_onNewStateSubject.add),
      )
      ..add(
        _onTryAgainSubject.stream
            .flatMap(
              (_) => _fetchFavoriteMovies(),
            )
            .listen(_onNewStateSubject.add),
      );
  }

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<FavoriteMoviesResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _repository = Repository();

  Stream<FavoriteMoviesResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<FavoriteMoviesResponseState> _fetchFavoriteMovies() async* {
    yield Loading();

    try {
      yield Success(
        favoriteMovies: await _repository.getFavoriteMovies(),
      );
    } catch (error) {
      yield Error(error: error);
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
  }
}
