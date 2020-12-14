import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.iconData,
    @required this.navigatorKey,
    @required this.name,
    @required this.initialPageName,
  })  : assert(iconData != null),
        assert(navigatorKey != null),
        assert(name != null);

  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final String name;
  final String initialPageName;

  AppFlow copy({
    IconData iconData,
    GlobalKey<NavigatorState> navigatorKey,
    String name,
    String initialPageName,
  }) =>
      AppFlow(
        iconData: iconData ?? this.iconData,
        navigatorKey: navigatorKey ?? this.navigatorKey,
        name: name ?? this.name,
        initialPageName: initialPageName ?? this.initialPageName,
      );
}
