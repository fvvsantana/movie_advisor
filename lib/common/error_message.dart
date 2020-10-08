import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    @required this.isServerError,
    @required this.onTryAgainTap,
  })  : assert(isServerError != null),
        assert(onTryAgainTap != null);

  final bool isServerError;
  final void Function() onTryAgainTap;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 6,
        child: Container(
          width: 250,
          //decoration: BoxDecoration(border: Border.all()),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isServerError ? 'Server error' : 'Connection error',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                isServerError
                    ? 'Server error'
                    : 'Server not reachable, please make sure you have '
                        'internet connection.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  FlatButton(
                    onPressed: onTryAgainTap,
                    //color: Colors.blue,
                    child: const Text(
                      'Try again',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
