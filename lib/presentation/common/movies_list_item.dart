import 'package:flutter/material.dart';

import 'package:domain/models/movie_summary.dart';
import 'package:movie_advisor/presentation/common/image_from_network.dart';

class MoviesListItem extends StatelessWidget {
  const MoviesListItem({
    @required this.movie,
    @required this.onTap,
  })  : assert(movie != null),
        assert(onTap != null);

  final MovieSummary movie;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(movie.id),
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: movie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Text(movie.title),
            ],
          ),
        ),
      );
}
