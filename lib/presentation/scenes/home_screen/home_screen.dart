import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/app_flow.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;
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
  Widget build(BuildContext context) {
    final currentFlow = _appFlows[_currentBarIndex];
    return WillPopScope(
      onWillPop: () async =>
      !await currentFlow.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentBarIndex,
          children: _appFlows
              .map(
                (flow) =>
                Navigator(
                  key: flow.navigatorKey,
                  onGenerateRoute: (_) =>
                      _buildAdaptivePageRoute(
                        builder: (_) => MoviesListPage(),
                      ),
                ),
          )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBarIndex,
          items: _appFlows
              .map(
                (appFlow) =>
                BottomNavigationBarItem(
                  label: appFlow.name,
                  icon: Icon(appFlow.iconData),
                ),
          )
              .toList(),
          onTap: (index) {
            if (index != _currentBarIndex) {
              setState(() {
                _currentBarIndex = index;
              });
            } else {
              currentFlow.navigatorKey.currentState
                  .popUntil((route) => route.isFirst);
            }
          },
        ),
      ),
    );
  }

  PageRoute<T> _buildAdaptivePageRoute<T>(
      {@required WidgetBuilder builder, RouteSettings settings}) =>
      Platform.isAndroid
          ? MaterialPageRoute(
        builder: builder,
        settings: settings,
      )
          : CupertinoPageRoute(
        builder: builder,
        settings: settings,
      );
}
