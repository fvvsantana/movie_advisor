import 'package:flutter/material.dart';
import 'package:movie_advisor/common/image_from_network.dart';
import 'package:movie_advisor/common/text_title.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({@required this.movieDetails})
      : assert(movieDetails != null);

  final Map<String, dynamic> movieDetails;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitle(
                movieDetails['title'],
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: movieDetails['poster_url'],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: TextTitle(
                  'Synopsis',
                ),
              ),
              Text(movieDetails['overview']),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: TextTitle(
                  'Genres',
                ),
              ),
              Text(
                  movieDetails['genres'].join(', '),
              ),
            ],
          ),
        ),
      );
}
