import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    @required this.onPressed,
    @required this.initialFavoriteState,
  })  : assert(onPressed != null),
        assert(initialFavoriteState != null);

  final Function(bool isFavorite) onPressed;
  final bool initialFavoriteState;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavoriteState;
  }

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
