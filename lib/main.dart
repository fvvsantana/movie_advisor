import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';

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
