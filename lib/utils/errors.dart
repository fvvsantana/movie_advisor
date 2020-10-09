import 'package:flutter/material.dart';

abstract class CustomError implements Exception {
  const CustomError({@required this.message}) : assert(message != null);
  final String message;

  @override
  String toString() => message;
}

abstract class NetworkError extends CustomError {
  const NetworkError({@required message})
      : assert(message != null),
        super(message: message);
}

class NoInternetError extends NetworkError {
  const NoInternetError() : super(
      message: 'Problem with internet connection or DNS service');
}

class ServerResponseError extends NetworkError {
  const ServerResponseError() : super(message: 'Bad response from the server');
}

class GenericError extends CustomError {
  const GenericError({@required message})
      : assert(message != null),
        super(message: message);

  factory GenericError.fromObject({@required Object object}){
    assert(object != null);
    return GenericError(message: 'Error: ${object.toString()}');
  }
}
