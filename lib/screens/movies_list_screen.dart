import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/utils/error_handling.dart';
import 'package:movie_advisor/utils/links.dart';
import 'package:movie_advisor/widgets/movies_list.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _movies;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    // Fetch movies list
    Dio().get(Links.moviesListUrl).catchError((error) {
      final DioError dioError = error;
      final isServerError = dioError.response != null;
      ErrorHandling.showErrorDialog(isServerError, context,
          MaterialPageRoute(builder: (_) => MoviesListScreen()));
    }).then((response) => setState(() {
          _isLoading = false;
          // Treat more server errors
          if (response.data == null) {
            ErrorHandling.showErrorDialog(true, context,
                MaterialPageRoute(builder: (_) => MoviesListScreen()));
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
            : MoviesList(_movies),
      );
}
