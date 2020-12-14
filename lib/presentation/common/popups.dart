import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  Scaffold.of(context).removeCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
