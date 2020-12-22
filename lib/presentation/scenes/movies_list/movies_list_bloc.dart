import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';
import 'package:movie_advisor/data/movie_repository.dart';

class MoviesListBloc {
  MoviesListBloc({@required this.repository}) : assert(repository != null) {
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

  final MovieRepository repository;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MoviesListResponseState>();
  final _onTryAgainSubject = StreamController<void>();

  Stream<MoviesListResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<MoviesListResponseState> _fetchMoviesList() async* {
    yield Loading();

    try {
      yield Success(
        moviesList: await repository.getMoviesList(),
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
