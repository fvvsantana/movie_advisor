import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/models/app_flow_data.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;
  final List<AppFlowData> _appFlows = [
    AppFlowData(
      name: 'Movies',
      iconData: Icons.ondemand_video,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlowData(
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
                (flow) => Navigator(
                  key: flow.navigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
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
                (appFlow) => BottomNavigationBarItem(
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
}
