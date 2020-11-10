import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/routing.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_advisor/generated/l10n.dart';

void main() {
  defineRoutes();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Movie Advisor',
        onGenerateRoute: (settings) => FluroRouter.appRouter
            .matchRoute(context, settings.name, routeSettings: settings)
            .route,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      );
}
