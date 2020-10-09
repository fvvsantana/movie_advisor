import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/errors.dart';

/*
  Widget to display error messages.
 */
class ErrorEmptyState extends StatelessWidget {
  factory ErrorEmptyState(
      {@required CustomError error, @required VoidCallback onTryAgainTap}) {
    assert(error != null);
    assert(onTryAgainTap != null);
    return ErrorEmptyState._(_ContentBuilder(error: error), onTryAgainTap);
  }

  const ErrorEmptyState._(this.content, this.onTryAgainTap);

  final _ContentBuilder content;
  final VoidCallback onTryAgainTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              content.title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              content.message,
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
  the CustomError received.
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
