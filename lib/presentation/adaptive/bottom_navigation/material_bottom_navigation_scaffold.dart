import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';

class MaterialBottomNavigationScaffold extends StatelessWidget {
  const MaterialBottomNavigationScaffold({
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
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: navigationBarTabs
              .map(
                (barItem) => Navigator(
                  key: barItem.navigatorKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: barItem.initialPageBuilder,
                  ),
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          items: navigationBarTabs
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: onItemSelected,
        ),
      );
}
