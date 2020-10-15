import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_item.dart';


class MoviesList extends StatelessWidget {
  const MoviesList({@required this.movies, @required this.callbacks})
      : assert(movies != null),
        assert(callbacks != null);

  final List<Map<String, dynamic>> movies;
  final List<VoidCallback> callbacks;

  @override
  Widget build(BuildContext context) =>
      ListView.builder(
        itemCount: movies.length,
        itemExtent: 70,
        itemBuilder: (_, index) {
          final movie = movies.elementAt(index);
          return MoviesListItem(
            id: movie['id'],
            title: movie['title'],
            imageUrl: movie['poster_url'],
            onTap: callbacks[index],
          );
        },
      );
}
