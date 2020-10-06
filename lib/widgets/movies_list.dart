import 'package:flutter/material.dart';

import 'movies_list_item.dart';

class MoviesList extends StatelessWidget {
  const MoviesList(this.movies);

  final List<Map<String,dynamic>> movies;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: movies.length,
        itemExtent: 70,
        itemBuilder: (_, index) {
          final movie = movies.elementAt(index);
          return MoviesListItem(
            id: movie['id'],
            title: movie['title'],
            imageUrl: movie['poster_url'],
          );
        },
      );
}
