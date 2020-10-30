import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/adaptive_bottom_navigation_scaffold.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/app_flow.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';
import 'package:movie_advisor/presentation/route_name_builder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<AppFlow> _appFlows = [
    AppFlow(
      name: 'Movies',
      iconData: Icons.ondemand_video,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      name: 'Favorites',
      iconData: Icons.star_border,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  @override
  Widget build(BuildContext context) => AdaptiveBottomNavigationScaffold(
        navigationBarTabs: _appFlows
            .map(
              (flow) => BottomNavigationTab(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  label: flow.name,
                  icon: Icon(flow.iconData),
                ),
                navigatorKey: flow.navigatorKey,
                initialPageName: RouteNameBuilder.moviesList(),
              ),
            )
            .toList(),
      );
}
