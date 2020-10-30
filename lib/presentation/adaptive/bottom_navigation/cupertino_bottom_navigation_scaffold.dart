import 'package:fluro/fluro.dart';
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
              // The [Navigator] widget has a initialRoute parameter, which
              // enables us to define which route it should push as the initial
              // one. See [MaterialBottomNavigationScaffold] for more details.
              //
              // The problem is that in the Cupertino version, we're not
              // instantiating the [Navigator] ourselves, instead we're
              // delegating it to the CupertinoTabView, which doesn't provides
              // us with a way to set the initialRoute name. The best
              // alternative I could find is to "change" the route's name of
              // our RouteSettings to our BottomNavigationTab's initialRouteName
              // when the onGenerateRoute is being executed for the initial
              // route.
              onGenerateRoute: (settings) {
                var routeSettings = settings;
                if (routeSettings.name == '/') {
                  routeSettings =
                      routeSettings.copyWith(name: barItem.initialPageName);
                }
                return FluroRouter.appRouter
                    .matchRoute(context, routeSettings.name,
                        routeSettings: routeSettings)
                    .route;
              });
        },
      );
}
