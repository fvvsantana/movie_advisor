import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/common/image_from_network.dart';

class MoviesListItem extends StatelessWidget {
  const MoviesListItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.onTap,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null),
        assert(onTap != null);

  final int id;
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
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
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      );
}
