import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/url_builder.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list.dart';


class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  CustomError _error;
  List<Map<String, dynamic>> _movies;

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

    // Fetch movies list
    Dio()
        .get(
      UrlBuilder.getMoviesList(),
    )
        .catchError((error) {
      // Treat errors
      if (error is DioError) {
        setState(() {
          _error = error.response == null
              ? const NoInternetError()
              : const ServerResponseError();
        });
      } else {
        _error = GenericError.fromObject(object: error);
      }
    }).then(
      (response) => setState(() {
        if (response == null) {
          return;
        }

        // Treat more server errors
        if (response.data == null) {
          _error = const ServerResponseError();
          return;
        }

        assert(response.data is List<dynamic>);
        // Request successful at this point
        _movies = response.data.cast<Map<String, dynamic>>().toList();
      }),
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
          title: const Text('Movie Advisor'),
        ),
        body: _movies != null
            ? MoviesList(movies: _movies)
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
