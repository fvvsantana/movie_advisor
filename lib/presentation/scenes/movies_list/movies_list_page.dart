import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  CustomError _error;
  List<MovieSummaryModel> _movies;
  final _movieRDS = MovieRemoteDataSource();

  /*
    Make an http request to get the movies data.
    Treat the errors involved on fetching data.
    If errors occurred, set the attribute _error.
    If no errors occurred, set the _movies data.
   */
  void _fetchAndSetMovies() {
    // Refresh page to show loading spinner
    setState(() {
      _error = null;
      _movies = null;
    });

    // Fetch data, treat success and error cases
    _movieRDS.getMoviesList().then((moviesList) {
      setState(() {
        _movies = moviesList;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _error = error;
      });
    });
  }

  void _pushMovieDetails(Object routeArguments) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MovieDetailsPage(),
        settings: RouteSettings(arguments: routeArguments),
      ),
    );
  }

  List<VoidCallback> _getMoviesListCallbacks() => _movies
      .map(
        (movie) => () => _pushMovieDetails(movie.id),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    _fetchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Movie Advisor'),
        ),
        body: _movies != null
            ? MoviesList(
                movies: _movies,
                callbacks: _getMoviesListCallbacks(),
              )
            : _error != null
                ? ErrorEmptyState.fromError(
                    error: _error,
                    onTryAgainTap: _fetchAndSetMovies,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      );
}
