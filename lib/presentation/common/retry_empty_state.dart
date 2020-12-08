import 'package:flutter/material.dart';

import 'package:movie_advisor/generated/l10n.dart';

class RetryEmptyState extends StatelessWidget {
  const RetryEmptyState({@required this.message, @required this.onRetry})
      : assert(message != null),
        assert(onRetry != null);

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            FlatButton(
              onPressed: onRetry,
              textColor: Theme.of(context).primaryColor,
              child: Text(S.of(context).retryEmptyStateRetryButtonText),
            ),
          ],
        ),
      );
}
