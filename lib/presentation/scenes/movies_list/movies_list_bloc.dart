import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_states.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  MoviesListBloc(){
    _fetchMoviesList().listen(_onNewStateSubject.add);
  }

  final _movieRDS = MovieRemoteDataSource();
  final _onNewStateSubject = BehaviorSubject<MoviesListResponseState>();

  Stream<MoviesListResponseState> get onNewState => _onNewStateSubject;

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

  /*
  void onTryAgain() {
    _fetchMoviesList().listen(_onNewStateSubject.add);
  }
  */

  void dispose() {
    _onNewStateSubject.close();
  }
}
