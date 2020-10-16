import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/models/app_flow.dart';
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
    return Scaffold(
      body: Navigator(
        key: currentFlow.navigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (_) => MoviesListPage(),
        ),
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
    );
  }
}
