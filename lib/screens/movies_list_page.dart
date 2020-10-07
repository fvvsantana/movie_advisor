import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/utils/error_handling.dart';
import 'package:movie_advisor/utils/links.dart';
import 'package:movie_advisor/widgets/movies_list.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
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
      showErrorDialog(
        context: context,
        isServerError: isServerError,
        route: MaterialPageRoute(builder: (_) => MoviesListPage()),
      );
    }).then((response) => setState(() {
          _isLoading = false;
          // Treat more server errors
          if (response.data == null) {
            showErrorDialog(
              context: context,
              isServerError: true,
              route: MaterialPageRoute(builder: (_) => MoviesListPage()),
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
            : MoviesList(_movies),
      );
}
