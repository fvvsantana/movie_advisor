import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.name,
    @required this.iconData,
    @required this.navigatorKey,
  })  : assert(name != null),
        assert(iconData != null),
        assert(navigatorKey != null);

  final String name;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;

  AppFlow copy({
    String name,
    IconData iconData,
    GlobalKey<NavigatorState> navigatorKey,
  }) =>
      AppFlow(
        name: name ?? this.name,
        iconData: iconData ?? this.iconData,
        navigatorKey: navigatorKey ?? this.navigatorKey,
      );
}
