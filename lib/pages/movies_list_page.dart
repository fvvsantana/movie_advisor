import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:movie_advisor/common/error_message.dart';
import 'package:movie_advisor/utils/request_state.dart';
import 'package:movie_advisor/utils/url_builder.dart';
import 'package:movie_advisor/common/movies_list.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}


class _MoviesListPageState extends State<MoviesListPage> {
  RequestState _requestState;
  bool _isServerError;
  List<Map<String, dynamic>> _movies;

  /*
    Make a http request to get the movies data.
    Update the _requestState and _isServerError during the process.
    Treat the errors involved on fetching data.
    If no errors occurred, set the _movies data.
   */
  void _fetchAndSetMovies() {
    setState(() {
      _requestState = RequestState.waiting;
    });
    // Fetch movies list
    Dio().get(UrlBuilder.moviesList()).catchError((error) {
      // Treat errors
      final DioError dioError = error;
      setState(() {
        _requestState = RequestState.error;
        _isServerError = dioError.response != null;
      });
    }).then((response) => setState(() {
          if (response == null) {
            return;
          }
          // Treat more server errors
          if (response.data == null) {
            _requestState = RequestState.error;
            _isServerError = true;
            return;
          }
          assert(response.data is List<dynamic>);
          _movies = response.data.cast<Map<String, dynamic>>().toList();
          _requestState = RequestState.successful;
          _isServerError = null;
        }));
  }

  @override
  void initState() {
    super.initState();
    _fetchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: _requestState == RequestState.error
            ? Center(
                child: ErrorMessage(
                  isServerError: _isServerError,
                  onTryAgainTap: _fetchAndSetMovies,
                ),
              )
            : _requestState == RequestState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MoviesList(movies: _movies),
      );
}
