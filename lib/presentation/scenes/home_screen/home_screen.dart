import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movie_advisor/presentation/adaptive/bottom_navigation/adaptive_bottom_navigation_scaffold.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/app_flow.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

import 'package:movie_advisor/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppFlow> _appFlows;
  Locale _userLocale;
  List<GlobalKey<NavigatorState>> _navigatorKeys;

  @override
  void initState() {
    super.initState();
    // Create keys only once to preserve the navigators' states
    _navigatorKeys = [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ];
  }

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

      _appFlows = [
        AppFlow(
          name: S.of(context).bottomNavigationMoviesTitle,
          iconData: Icons.ondemand_video,
          navigatorKey: _navigatorKeys[0],
        ),
        AppFlow(
          name: S.of(context).bottomNavigationFavoritesTitle,
          iconData: Icons.star_border,
          navigatorKey: _navigatorKeys[1],
        ),
      ];
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
                initialPageBuilder: (_) => MoviesListPage(),
              ),
            )
            .toList(),
      );
}
