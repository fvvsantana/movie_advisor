import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:movie_advisor/common/global_providers.dart';
import 'package:movie_advisor/generated/l10n.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: globalProviders,
        child: Consumer<FluroRouter>(
          builder: (_, router, __) => MaterialApp(
            title: 'Movie Advisor',
            onGenerateRoute: (settings) => router
                .matchRoute(context, settings.name, routeSettings: settings)
                .route,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          ),
        ),
      );
}
