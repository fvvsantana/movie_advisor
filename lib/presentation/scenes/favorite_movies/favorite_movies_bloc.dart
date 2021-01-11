import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:domain/use_cases/get_favorite_movies_uc.dart';
import 'package:movie_advisor/presentation/scenes/favorite_movies/favorite_movies_states.dart';
import 'package:movie_advisor/presentation/mappers/domain_to_view.dart';

class FavoriteMoviesBloc {
  FavoriteMoviesBloc({@required this.getFavoriteMoviesUC})
      : assert(getFavoriteMoviesUC != null) {
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

  final GetFavoriteMoviesUC getFavoriteMoviesUC;

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
        favoriteMovies: (await getFavoriteMoviesUC.getFuture()).toVM(),
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
