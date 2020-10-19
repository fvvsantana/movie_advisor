import 'package:flutter/material.dart';
import 'package:movie_advisor/data/models/movie_summary_model.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_item.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({@required this.movies, @required this.callbacks})
      : assert(movies != null),
        assert(callbacks != null);

  final List<MovieSummaryModel> movies;
  final List<VoidCallback> callbacks;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: movies.length,
        itemExtent: 70,
        itemBuilder: (_, index) => MoviesListItem(
            movie: movies.elementAt(index),
            onTap: callbacks[index],
          ),
      );
}
