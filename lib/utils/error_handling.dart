import 'package:flutter/material.dart';

class CustomError implements Exception {
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
      message: 'Make sure you have internet connection or check your DNS '
          'settings.');
}

class ServerResponseError extends NetworkError {
  const ServerResponseError() : super(message: 'Server error.');
}

String generateTitle(CustomError error) {
  try {
    throw error;
  } on NoInternetError {
    return 'Connection Error';
  } on ServerResponseError{
    return 'Server error';
  } catch(_){
    return 'Error';
  }
}

