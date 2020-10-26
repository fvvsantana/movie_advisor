import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';

class CupertinoBottomNavigationScaffold extends StatefulWidget {
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
  _CupertinoBottomNavigationScaffoldState createState() =>
      _CupertinoBottomNavigationScaffoldState();
}

class _CupertinoBottomNavigationScaffoldState
    extends State<CupertinoBottomNavigationScaffold> {
  List<GlobalKey> _navigatorKeys;

  @override
  void initState() {
    super.initState();
    _navigatorKeys =
        widget.navigationBarTabs.map((tab) => tab.navigatorKey).toList();
  }

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        controller: CupertinoTabController(initialIndex: widget.selectedIndex),
        tabBar: CupertinoTabBar(
          items: widget.navigationBarTabs
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: widget.onItemSelected,
        ),
        tabBuilder: (context, index) {
          final barItem = widget.navigationBarTabs[index];
          return CupertinoTabView(
            //navigatorKey: barItem.navigatorKey,
            navigatorKey: _navigatorKeys[index],
            onGenerateRoute: (settings) => CupertinoPageRoute(
              settings: settings,
              builder: barItem.initialPageBuilder,
            ),
          );
        },
      );
}
