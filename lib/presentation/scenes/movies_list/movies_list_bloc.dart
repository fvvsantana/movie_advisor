import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/presentation/mappers/domain_to_view.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';
import 'package:domain/use_cases/get_movies_list_uc.dart';

class MoviesListBloc {
  MoviesListBloc({@required this.getMoviesListUC})
      : assert(getMoviesListUC != null) {
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

  final GetMoviesListUC getMoviesListUC;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MoviesListResponseState>();
  final _onTryAgainSubject = StreamController<void>();

  Stream<MoviesListResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<MoviesListResponseState> _fetchMoviesList() async* {
    yield Loading();

    try {
      yield Success(
        moviesList: (await getMoviesListUC.getFuture()).toView(),
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
