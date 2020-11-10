import 'package:flutter/widgets.dart';

class BottomNavigationTab {
  const BottomNavigationTab({
    @required this.bottomNavigationBarItem,
    @required this.navigatorKey,
    @required this.initialPageName,
  })  : assert(bottomNavigationBarItem != null),
        assert(navigatorKey != null),
        assert(initialPageName != null);

  final BottomNavigationBarItem bottomNavigationBarItem;
  final GlobalKey<NavigatorState> navigatorKey;
  final String initialPageName;
}