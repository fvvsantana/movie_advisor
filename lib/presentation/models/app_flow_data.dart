import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlowData {
  const AppFlowData({
    @required this.name,
    @required this.iconData,
    @required this.navigatorKey,
  })  : assert(name != null),
        assert(iconData != null),
        assert(navigatorKey != null);

  final String name;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
}
