import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/utils/links.dart';
import 'package:movie_advisor/widgets/movies_list.dart';
import 'package:movie_advisor/widgets/movies_list_item.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  Future<Response> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = Dio().get(Links.moviesListUrl);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: FutureBuilder(
          future: moviesFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Response response = snapshot.data;
              if(response.data == null){
                // TODO: tread this case
              }
              return Center(
                child: MoviesList(response.data),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
}
