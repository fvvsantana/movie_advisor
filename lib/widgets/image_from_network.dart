import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/links.dart';

class ImageFromNetwork extends StatelessWidget {
  const ImageFromNetwork({this.imageUrl, this.fit = BoxFit.contain});

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => Image.network(
        imageUrl,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
        fit: fit,
        errorBuilder: (_, __, ___) => Image.asset(
          '${Links.imagesFolder}/no_image_100.png',
    ),

  );
}
