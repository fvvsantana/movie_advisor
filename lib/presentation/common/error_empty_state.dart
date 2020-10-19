import 'package:flutter/material.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/presentation/common/text_title.dart';

/// Widget to display error messages.
class ErrorEmptyState extends StatelessWidget {
  const ErrorEmptyState({
    @required this.title,
    @required this.message,
    @required this.onTryAgainTap,
  })  : assert(title != null),
        assert(message != null),
        assert(onTryAgainTap != null);

  // Build the content of the widget from the CustomError
  factory ErrorEmptyState.fromError(
      {@required CustomError error, @required VoidCallback onTryAgainTap}) {
    assert(error != null);
    assert(onTryAgainTap != null);
    final content = _ContentBuilder(error: error);
    return ErrorEmptyState(
      title: content.title,
      message: content.message,
      onTryAgainTap: onTryAgainTap,
    );
  }

  final String title;
  final String message;
  final VoidCallback onTryAgainTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextTitle(
              text: title,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            RaisedButton(
              onPressed: onTryAgainTap,
              color: Colors.blue,
              child: const Text(
                'Try again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
}

/*
  This class generates user-friendly content to be displayed on the page using
  the received CustomError.
 */
class _ContentBuilder {
  _ContentBuilder({@required this.error}) : assert(error != null) {
    if (error is NoInternetError) {
      title = 'Connection Error';
      message = 'Make sure you have internet connection or check your DNS '
          'settings.';
    } else if (error is ServerResponseError) {
      title = 'Server error';
      message = 'Server error';
    } else {
      title = 'Error';
      message = 'Error';
    }
  }

  final CustomError error;
  String title;
  String message;
}
