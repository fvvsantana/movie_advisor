import 'package:flutter/foundation.dart';

abstract class CustomError implements Exception {
  const CustomError({@required this.message}) : assert(message != null);
  final String message;

  @override
  String toString() => message;
}

class NoInternetError extends CustomError {
  const NoInternetError()
      : super(message: 'Problem with internet connection or DNS service');
}
