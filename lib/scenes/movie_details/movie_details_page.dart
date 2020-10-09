import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:movie_advisor/common/error_empty_state.dart';
import 'package:movie_advisor/scenes/movie_details/movie_details.dart';
import 'package:movie_advisor/utils/errors.dart';
import 'package:movie_advisor/utils/url_builder.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  CustomError _error;
  Map<String, dynamic> _movieDetails;
  bool _isFirstCall = true;
  int _movieId;

  /*
    Make an http request to get the movie details data.
    Treat the errors involved on fetching data.
    If errors occurred, set the attribute _error.
    If no errors occurred, set the _movies data.
   */
  void _fetchAndSetMovieDetails() {
    // Refresh page to show loading spinner
    setState(() {
      _error = null;
      _movieDetails = null;
    });

    // Fetch movies list
    Dio().get(UrlBuilder.movieDetails(_movieId)).catchError((error) {
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
    }).then((response) => setState(() {
          if (response == null) {
            return;
          }

          // Treat more server errors
          if (response.data == null) {
            _error = const ServerResponseError();
            return;
          }

          // Request successful at this point
          _movieDetails = response.data;
        }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstCall) {
      _isFirstCall = false;
      _movieId = ModalRoute.of(context).settings.arguments;
      _fetchAndSetMovieDetails();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: _movieDetails != null
            ? MovieDetails(movieDetails: _movieDetails)
            : _error != null
                ? ErrorEmptyState(
                    error: _error,
                    onTryAgainTap: _fetchAndSetMovieDetails,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      );
}
