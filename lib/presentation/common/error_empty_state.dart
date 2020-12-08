import 'package:flutter/material.dart';
import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/presentation/common/title_text.dart';

import 'package:movie_advisor/generated/l10n.dart';

/// Widget to display error messages.
class ErrorEmptyState extends StatelessWidget {
  const ErrorEmptyState({
    @required this.error,
    @required this.onTryAgainTap,
  })  : assert(error != null),
        assert(onTryAgainTap != null);

  final Object error;
  final VoidCallback onTryAgainTap;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(
                text: _getErrorTitle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _getErrorContent(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              RaisedButton(
                onPressed: onTryAgainTap,
                color: Colors.blue,
                child: Text(
                  S.of(context).errorEmptyStateButtonTitle,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );

  String _getErrorTitle(BuildContext context) {
    if (error is NoInternetError) {
      return S.of(context).errorEmptyStateNoInternetErrorTitle;
    } else {
      return S.of(context).errorEmptyStateGenericErrorTitle;
    }
  }

  String _getErrorContent(BuildContext context) {
    if (error is NoInternetError) {
      return S.of(context).errorEmptyStateNoInternetErrorContent;
    } else {
      return S.of(context).errorEmptyStateGenericErrorContent;
    }
  }
}
