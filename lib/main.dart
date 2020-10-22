import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';
import 'package:movie_advisor/generated/l10n.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Movie Advisor',
        home: MoviesListPage(),
        localizationsDelegates: [
          // 1
          S.delegate,
          // 2
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      );
}
