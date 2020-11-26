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
        _fetchIsFavorite().listen(_onIsFavoriteResponseSubject.sink.add),
      )
      ..add(
        _handleFavoritingRequests(),
      );
  }

  final int movieId;

  final _subscriptions = CompositeSubscription();
  final _onNewStateSubject = BehaviorSubject<MovieDetailsResponseState>();
  final _onTryAgainSubject = StreamController<void>();
  final _onIsFavoriteResponseSubject = StreamController<bool>();
  final _onFavoritingRequestSubject = StreamController<bool>();
  final _onFavoritingErrorSubject = StreamController<bool>();
  final _onUnfavoritingErrorSubject = StreamController<bool>();
  final _repository = Repository();

  Stream<MovieDetailsResponseState> get onNewState => _onNewStateSubject;

  Sink<void> get onTryAgain => _onTryAgainSubject.sink;

  Stream<bool> get onIsFavoriteResponse => _onIsFavoriteResponseSubject.stream;

  Sink<bool> get onFavoritingRequest => _onFavoritingRequestSubject.sink;

  Stream<bool> get onFavoritingError => _onFavoritingErrorSubject.stream;

  Stream<bool> get onUnfavoritingError => _onUnfavoritingErrorSubject.stream;

  Stream<MovieDetailsResponseState> _fetchMovieDetails() async* {
    yield Loading();

    try {
      yield Success(
        movieDetails: await _repository.getMovieDetails(movieId),
      );
    } catch (error) {
      yield Error.fromObject(error: error);
    }
  }

  Stream<bool> _fetchIsFavorite() async* {
    try {
      yield await _repository.isFavoriteMovie(movieId);
    } catch (_) {
      yield null;
    }
  }

  /*
    It listens to requests for favoriting the movie, coming from the
    _onFavoritingRequestSubject stream. It follows the request to the data base,
    and it reports the result of this request to other two stream controllers:
    _onFavoritingErrorSubject and _onUnfavoritingErrorSubject.
   */
  StreamSubscription<bool> _handleFavoritingRequests() =>
      _onFavoritingRequestSubject.stream.listen((favoriting) async {
        if (favoriting) {
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
      });

  void dispose() {
    _subscriptions.dispose();
    _onNewStateSubject.close();
    _onTryAgainSubject.close();
    _onIsFavoriteResponseSubject.close();
    _onFavoritingRequestSubject.close();
    _onFavoritingErrorSubject.close();
    _onUnfavoritingErrorSubject.close();
  }
}
