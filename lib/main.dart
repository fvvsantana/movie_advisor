import 'package:flutter/material.dart';
import 'package:movie_advisor/screens/movie_details_screen.dart';
import 'package:movie_advisor/screens/movies_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Movie Advisor',
      home: MoviesListScreen(),
      routes: {
        MovieDetailsScreen.routeName: (_) => MovieDetailsScreen(),
      },
    );
}

