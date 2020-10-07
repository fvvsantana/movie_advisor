import 'package:flutter/material.dart';

void showErrorDialog({
  @required BuildContext context,
  @required bool isServerError,
  @required Route route,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(isServerError ? 'Server error' : 'Connection error'),
      content: Text(isServerError
          ? 'Server error'
          : 'Server not reachable, please make sure you have '
              'internet connection.'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(route);
          },
          child: const Text('Try again'),
        ),
      ],
    ),
  );
}
