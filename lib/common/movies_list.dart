import 'package:flutter/material.dart';

import 'package:movie_advisor/common/movies_list_item.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({@required this.movies}) : assert(movies != null);

  final List<Map<String, dynamic>> movies;

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
