import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({@required this.text}) : assert(text != null);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      );
}
