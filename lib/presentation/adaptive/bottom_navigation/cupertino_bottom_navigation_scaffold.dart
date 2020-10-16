import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';

class CupertinoBottomNavigationScaffold extends StatelessWidget {
  const CupertinoBottomNavigationScaffold({
    @required this.navigationBarTabs,
    @required this.onItemSelected,
    @required this.selectedIndex,
    Key key,
  })  : assert(navigationBarTabs != null),
        assert(onItemSelected != null),
        assert(selectedIndex != null),
        super(key: key);

  final List<BottomNavigationTab> navigationBarTabs;

  final ValueChanged<int> onItemSelected;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    controller: CupertinoTabController(initialIndex: selectedIndex),
    tabBar: CupertinoTabBar(
      items: navigationBarTabs
          .map(
            (item) => item.bottomNavigationBarItem,
      )
          .toList(),
      onTap: onItemSelected,
    ),
    tabBuilder: (context, index) {
      final barItem = navigationBarTabs[index];
      return CupertinoTabView(
        navigatorKey: barItem.navigatorKey,
        onGenerateRoute: (settings) => CupertinoPageRoute(
          settings: settings,
          builder: barItem.initialPageBuilder,
        ),
      );
    },
  );
}