import 'package:flutter/material.dart';

class ImageFromNetwork extends StatelessWidget {
  const ImageFromNetwork({@required this.imageUrl, this.fit = BoxFit.contain})
      : assert(imageUrl != null);

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => Image.network(
        imageUrl,
        loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
            ? child
            : Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              ),
        fit: fit,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/no_image_100.png',
        ),
      );
}
