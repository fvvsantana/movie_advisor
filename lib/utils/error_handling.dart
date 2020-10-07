import 'package:flutter/material.dart';

void showErrorDialog({
  @required BuildContext context,
  @required bool isServerError,
  @required void Function() onTryAgainTap,
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
          onPressed: onTryAgainTap,
          child: const Text('Try again'),
        ),
      ],
    ),
  );
}
