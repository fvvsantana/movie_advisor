import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/route_name_builder.dart';
import 'package:movie_advisor/presentation/scenes/home_screen/home_screen.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details_page.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

void main() {
  // Define routes
  FluroRouter.appRouter
    ..define(
      '/',
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
      '${RouteNameBuilder.moviesResource}/:id',
      handler: Handler(
        handlerFunc: (context, params) => MovieDetailsPage(
          id: int.parse(params['id'][0]),
        ),
      ),
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
      );
}
