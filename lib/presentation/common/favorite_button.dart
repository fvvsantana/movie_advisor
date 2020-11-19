import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({@required this.onPressed}) : assert(onPressed != null);

  final Function(bool isFavorite) onPressed;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

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
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
          widget.onPressed(isFavorite);
        },
      );
}
