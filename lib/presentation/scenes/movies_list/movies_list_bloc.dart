import 'dart:async';

import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  MoviesListBloc() {
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
  final _onNewStateSubject = BehaviorSubject<MoviesListResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _movieRDS = MovieRemoteDataSource();

  Stream<MoviesListResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<MoviesListResponseState> _fetchMoviesList() async* {
    yield Loading();

    try {
      yield Success(
        moviesList: await _movieRDS.getMoviesList(),
      );
    } catch (error) {
      yield Error(
        error: error is CustomError
            ? error
            : GenericError.fromObject(object: error),
      );
    }
  }

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
  }
}
