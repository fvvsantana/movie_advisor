import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_states.dart';

class MovieDetailsBloc {
  MovieDetailsBloc({@required remoteDS, @required movieId})
      : _remoteDS = remoteDS,
        _movieId = movieId,
        assert(remoteDS != null),
        assert(movieId != null) {
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
      );
  }

  final MovieRemoteDataSource _remoteDS;
  final int _movieId;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: await _remoteDS.getMovieDetails(_movieId),
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
