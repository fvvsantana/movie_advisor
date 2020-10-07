import 'package:flutter/material.dart';
import 'package:movie_advisor/screens/movies_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Movie Advisor',
      home: MoviesListPage(),
    );
}

