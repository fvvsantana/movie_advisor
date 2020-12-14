import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'package:movie_advisor/common/global_providers.dart';
import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/routing.dart';

Future<void> main() async {
  defineRoutes();

  WidgetsFlutterBinding.ensureInitialized();

  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter<MovieSummaryCM>(
      MovieSummaryCMAdapter(),
    )
    ..registerAdapter<MovieDetailsCM>(
      MovieDetailsCMAdapter(),
    );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: globalProviders,
        child: MaterialApp(
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
        ),
      );
}
