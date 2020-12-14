import 'package:flutter/foundation.dart';

abstract class FavoriteActionResult {}

class FavoriteError implements FavoriteActionResult {
  const FavoriteError({@required this.newIsFavorite})
      : assert(newIsFavorite != null);
  final bool newIsFavorite;
}

class FavoriteSuccess implements FavoriteActionResult {
  const FavoriteSuccess({@required this.newIsFavorite})
      : assert(newIsFavorite != null);
  final bool newIsFavorite;
}

class FavoriteRaceConditionError implements FavoriteActionResult {}
