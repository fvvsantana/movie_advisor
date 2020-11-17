import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:movie_advisor/data/cache/models/movie_details_cm.dart';
import 'package:movie_advisor/data/cache/models/movie_summary_cm.dart';
import 'package:path_provider/path_provider.dart';

import 'package:movie_advisor/presentation/route_name_builder.dart';
import 'package:movie_advisor/generated/l10n.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

Future<void> main() async {
  // Define routes
  FluroRouter.appRouter
    ..define(
      RouteNameBuilder.homeResource,
      handler: Handler(
        handlerFunc: (context, params) => HomeScreen(),
      ),
    )
    ..define(
      RouteNameBuilder.moviesResource,
      handler: Handler(
        handlerFunc: (context, params) => MoviesListPage(),
      ),
    )
    ..define(
      '${RouteNameBuilder.moviesResource}/:${RouteNameBuilder.moviesPathParameterId}',
      handler: Handler(
        handlerFunc: (context, params) => MovieDetailsPage(
          id: int.parse(params[RouteNameBuilder.moviesPathParameterId][0]),
        ),
      ),
    );

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
