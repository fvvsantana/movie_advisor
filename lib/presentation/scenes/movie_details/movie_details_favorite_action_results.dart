import 'package:flutter/foundation.dart';

abstract class FavoriteActionResult {}

class FavoriteError implements FavoriteActionResult {
  const FavoriteError({@required this.favoriting}) : assert(favoriting != null);
  final bool favoriting;
}

class FavoriteSuccess implements FavoriteActionResult {
  const FavoriteSuccess({@required this.favoriting})
      : assert(favoriting != null);
  final bool favoriting;
}
