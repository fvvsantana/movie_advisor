import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/common/favorite_button.dart';
import 'package:movie_advisor/presentation/common/image_from_network.dart';
import 'package:movie_advisor/presentation/common/title_text.dart';
import 'package:movie_advisor/presentation/models/movie_details_vm.dart';

class MovieDetailsContent extends StatelessWidget {
  const MovieDetailsContent({
    @required this.movieDetails,
    @required this.onFavoriteButtonPressed,
  })  : assert(movieDetails != null),
        assert(onFavoriteButtonPressed != null);

  final MovieDetailsVM movieDetails;
  final VoidCallback onFavoriteButtonPressed;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TitleText(
                      text: movieDetails.title,
                    ),
                  ),
                  FavoriteButton(
                    onPressed: onFavoriteButtonPressed,
                    isFavorite: movieDetails.isFavorite,
                  ),
                ],
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
