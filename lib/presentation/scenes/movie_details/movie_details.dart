import 'package:flutter/material.dart';

import 'package:movie_advisor/data/remote/models/movie_details_model.dart';
import 'package:movie_advisor/presentation/common/image_from_network.dart';
import 'package:movie_advisor/presentation/common/title_text.dart';

import 'package:movie_advisor/generated/l10n.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({@required this.movieDetails})
      : assert(movieDetails != null);

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: movieDetails.title,
              ),
              Container(
                height: 300,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: movieDetails.imageUrl,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TitleText(
                text: S.of(context).movieDetailsSynopsisTitle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(movieDetails.synopsis),
              const SizedBox(
                height: 8,
              ),
              TitleText(
                text: S.of(context).movieDetailsGenresTitle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                  movieDetails.genres.join(', '),
              ),
            ],
          ),
        ),
      );
}
