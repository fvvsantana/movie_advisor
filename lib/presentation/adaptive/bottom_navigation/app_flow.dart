import 'package:flutter/widgets.dart';

/// Holds information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.iconData,
    @required this.navigatorKey,
    this.name = '',
  })  : assert(iconData != null),
        assert(navigatorKey != null),
        assert(name != null);

  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
  final String name;

  AppFlow copy({
    IconData iconData,
    GlobalKey<NavigatorState> navigatorKey,
    String name,
  }) =>
      AppFlow(
        iconData: iconData ?? this.iconData,
        navigatorKey: navigatorKey ?? this.navigatorKey,
        name: name ?? this.name,
      );
}
