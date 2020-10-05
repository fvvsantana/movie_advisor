import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isLoading = true;
    Dio()
        .get(Links.moviesListUrl)
        .catchError((error) => null) // TODO: treat this error
        .then((response) => setState(() {
              _isLoading = false;
              if (response.data == null) {
                // TODO: treat this error
                print('NO DATA!');
              }
              print(response.data.runtimeType);
              _movies = (response.data as List<dynamic>).cast();
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
