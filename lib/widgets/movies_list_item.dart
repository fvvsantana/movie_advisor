import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/screens/movie_details_screen.dart';
import 'package:movie_advisor/utils/links.dart';

class MoviesListItem extends StatelessWidget {
  const MoviesListItem({this.id, this.title, this.imageUrl});

  final int id;
  final String title;
  final String imageUrl;

  Object ignoreExceptions(Object Function() builder) {
    Object object;
    try {
      object = builder();
    } catch (error) {}
    return object;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(),
            settings: RouteSettings(arguments: id))),
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),

                ),
                /*
                child: Image.network(
                  imageUrl,
                  loadingBuilder: (_, __, ___) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    '${Links.imagesFolder}/no_image_100.png',
                    fit: BoxFit.cover,
                  ),
                ),
               */
              ),
              Text(title),
            ],
          ),
        ),
      );
}
