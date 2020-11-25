import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    @required this.onPressed,
    @required this.isFavorite,
  })  : assert(onPressed != null),
        assert(isFavorite != null);

  final VoidCallback onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: isFavorite
            ? const Icon(
                Icons.star,
                color: Colors.amber,
              )
            : const Icon(
                Icons.star_border,
              ),
        onPressed: onPressed,
      );
}
