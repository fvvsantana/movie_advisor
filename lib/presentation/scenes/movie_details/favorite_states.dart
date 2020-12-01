import 'package:flutter/foundation.dart';

abstract class FavoriteResponseState {}

class FavoriteError implements FavoriteResponseState {
  const FavoriteError({@required this.favoriting}) : assert(favoriting != null);
  final bool favoriting;
}

class FavoriteSuccess implements FavoriteResponseState {
  const FavoriteSuccess({@required this.favoriting})
      : assert(favoriting != null);
  final bool favoriting;
}
