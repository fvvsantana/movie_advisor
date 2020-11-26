import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movie_advisor/presentation/adaptive/bottom_navigation/adaptive_bottom_navigation_scaffold.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/app_flow.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';
import 'package:movie_advisor/presentation/routing.dart';

import 'package:movie_advisor/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create keys only once to preserve the navigators' states
  Locale _userLocale;

  List<AppFlow> _appFlows;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Detecting if the locale changed here is needed, because the user could
    // change the language of the app during runtime, so that we should
    // translate the bottom navigation bar labels.
    // Also using the Localizations.localeOf(context) turns this class into a
    // listener for language changes. Then flutter will automatically call
    // didChangeDependencies whenever the language of the app changes during
    // runtime.
    final newLocale = Localizations.localeOf(context);
    if (newLocale != _userLocale) {
      _userLocale = newLocale;

      if (_appFlows == null) {
        _appFlows = [
          AppFlow(
            iconData: Icons.ondemand_video,
            navigatorKey: GlobalKey<NavigatorState>(),
            name: S.of(context).bottomNavigationMoviesTitle,
            initialPageName: RouteNameBuilder.moviesList(),
          ),
          AppFlow(
            iconData: Icons.star_border,
            navigatorKey: GlobalKey<NavigatorState>(),
            name: S.of(context).bottomNavigationFavoritesTitle,
            initialPageName: RouteNameBuilder.favoritesList(),
          ),
        ];
      } else {
        _appFlows = [
          _appFlows[0].copy(name: S.of(context).bottomNavigationMoviesTitle),
          _appFlows[1].copy(name: S.of(context).bottomNavigationFavoritesTitle),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) => AdaptiveBottomNavigationScaffold(
        navigationBarTabs: _appFlows
            .map(
              (flow) => BottomNavigationTab(
                bottomNavigationBarItem: BottomNavigationBarItem(
                  label: flow.name,
                  icon: Icon(flow.iconData),
                ),
                navigatorKey: flow.navigatorKey,
                initialPageName: flow.initialPageName,
              ),
            )
            .toList(),
      );
}
