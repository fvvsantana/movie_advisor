import 'package:flutter/material.dart';
import 'package:movie_advisor/common/image_from_network.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({@required this.movieDetails})
      : assert(movieDetails != null);

  final Map<String, dynamic> movieDetails;

  String _parseGenres(List<String> genres) =>
      (StringBuffer()..writeAll(genres, ', ')).toString();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieDetails['title'],
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: movieDetails['poster_url'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Synopsis',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(movieDetails['overview']),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Genres',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(
                  _parseGenres(movieDetails['genres'].cast<String>().toList())),
            ],
          ),
        ),
      );
}
