import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  const MoviesList(this._movies);

  final List<Map<String, dynamic>> _movies;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: _movies.length,
        itemExtent: 60,
        itemBuilder: (_, index) => ,
      );
}
