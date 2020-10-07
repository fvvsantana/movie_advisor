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

  void tryAgain(){
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MoviesListPage()));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    // Fetch movies list
    Dio().get(UrlBuilder.moviesList()).catchError((error) {
      final DioError dioError = error;
      final isServerError = dioError.response != null;
      showErrorDialog(
          context: context,
          isServerError: isServerError,
          onTryAgainTap: tryAgain,
      );
    }).then((response) => setState(() {
          _isLoading = false;
          // Treat more server errors
          if (response.data == null) {
            showErrorDialog(
              context: context,
              isServerError: true,
              onTryAgainTap: tryAgain,
            );
            _isLoading = true;
            return;
          }
          assert(response.data is List<dynamic>);
          _movies = response.data.cast<Map<String, dynamic>>().toList();
        }));
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
