import 'package:flutter/foundation.dart';

abstract class FavoriteActionResult {}

class FavoriteError implements FavoriteActionResult {
  const FavoriteError({@required this.isFavoriting})
      : assert(isFavoriting != null);
  final bool isFavoriting;
}

class FavoriteSuccess implements FavoriteActionResult {
  const FavoriteSuccess({@required this.isFavoriting})
      : assert(isFavoriting != null);
  final bool isFavoriting;
}
