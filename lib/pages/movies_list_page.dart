import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/utils/error_handling.dart';
import 'package:movie_advisor/utils/url_builder.dart';
import 'package:movie_advisor/common/movies_list.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _movies;

  /*
    Make a http request to get the movies data.
    Update the isLoading state during the process.
    Treat the errors involved on fetching data.
    If no errors occurred, set the _movies data.
   */
  void fetchAndSetMovies() {
    setState(() {
      _isLoading = true;
    });
    // Fetch movies list
    Dio().get(UrlBuilder.moviesList()).catchError((error) {
      // Treat errors
      final DioError dioError = error;
      final isServerError = dioError.response != null;
      showErrorDialog(
        context: context,
        isServerError: isServerError,
        onTryAgainTap: tryAgain,
      );
    }).then((response) => setState(() {
          if (response == null) {
            return;
          }
          // Treat more server errors
          if (response.data == null) {
            showErrorDialog(
              context: context,
              isServerError: true,
              onTryAgainTap: tryAgain,
            );
            return;
          }
          assert(response.data is List<dynamic>);
          _movies = response.data.cast<Map<String, dynamic>>().toList();
          _isLoading = false;
        }));
  }

  // Pop dialog and try to fetch the movies data again
  void tryAgain() {
    Navigator.of(context).pop();
    fetchAndSetMovies();
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : MoviesList(movies: _movies),
      );
}
