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

class GenericError extends CustomError {
  const GenericError({@required message})
      : assert(message != null),
        super(message: message);

  factory GenericError.fromObject({@required Object object}) {
    assert(object != null);
    return GenericError(
      message: object.toString(),
    );
  }
}

extension ErrorConversion on Object {
  CustomError toCustomError() => this is CustomError
      ? this
      : GenericError(
          message: toString(),
        );
}
