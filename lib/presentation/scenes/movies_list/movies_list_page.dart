import 'package:flutter/material.dart';

import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';
import 'package:movie_advisor/data/remote/movie_remote_data_source.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list.dart';

import 'package:movie_advisor/generated/l10n.dart';

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

  void _pushMovieDetails(int movieId) {
    Navigator.of(context).pushNamed(
      RouteNameBuilder.movieById(movieId),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).moviesListAppBarTitle),
        ),
        body: _movies != null
            ? MoviesList(
                movies: _movies,
                onMovieTap: _pushMovieDetails,
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
