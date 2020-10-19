import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/common/image_from_network.dart';
import 'package:movie_advisor/presentation/common/title_text.dart';

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
              TitleText(
                text: movieDetails['title'],
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: movieDetails['poster_url'],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TitleText(
                text: 'Synopsis',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(movieDetails['overview']),
              const SizedBox(
                height: 8,
              ),
              const TitleText(
                text: 'Genres',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                  movieDetails['genres'].join(', '),
              ),
            ],
          ),
        ),
      );
}
