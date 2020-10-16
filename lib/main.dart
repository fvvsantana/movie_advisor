import 'package:flutter/material.dart';
import 'package:movie_advisor/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Movie Advisor',
        home: HomeScreen(),
      );
}
