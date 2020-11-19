import 'dart:async';

import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/repository.dart';

class FavoriteMoviesBloc {
  FavoriteMoviesBloc() {
    _subscriptions
      ..add(
        _fetchMoviesList().listen(_onNewStateSubject.add),
      )
      ..add(
        _onTryAgainSubject.stream
            .flatMap(
              (_) => _fetchMoviesList(),
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

  Stream<FavoriteMoviesResponseState> _fetchMoviesList() async* {
    yield Loading();

    try {
      yield Success(
        moviesList: await _repository.getMoviesList(),
      );
    } catch (error) {
      yield Error.fromObject(error: error);
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
  }
}
