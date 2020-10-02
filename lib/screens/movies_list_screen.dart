import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:movie_advisor/utils/links.dart';

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
              final response = snapshot.data;
              return Center(
                child: Text(response.data.toString()),
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
