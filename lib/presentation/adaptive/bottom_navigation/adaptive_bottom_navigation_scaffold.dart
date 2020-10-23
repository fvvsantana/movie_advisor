import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/cupertino_bottom_navigation_scaffold.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/material_bottom_navigation_scaffold.dart';

class AdaptiveBottomNavigationScaffold extends StatefulWidget {
  const AdaptiveBottomNavigationScaffold({
    @required this.navigationBarTabs,
    Key key,
  })  : assert(navigationBarTabs != null),
        super(key: key);

  final List<BottomNavigationTab> navigationBarTabs;

  @override
  _AdaptiveBottomNavigationScaffoldState createState() =>
      _AdaptiveBottomNavigationScaffoldState();
}

class _AdaptiveBottomNavigationScaffoldState
    extends State<AdaptiveBottomNavigationScaffold> {
  int _currentlySelectedIndex = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => !await widget
            .navigationBarTabs[_currentlySelectedIndex]
            .navigatorKey
            .currentState
            .maybePop(),
        child: Platform.isAndroid
            ? MaterialBottomNavigationScaffold(
                navigationBarTabs: widget.navigationBarTabs,
                onItemSelected: onTabSelected,
                selectedIndex: _currentlySelectedIndex,
              )
            : CupertinoBottomNavigationScaffold(
                navigationBarTabs: widget.navigationBarTabs,
                onItemSelected: onTabSelected,
                selectedIndex: _currentlySelectedIndex,
              ),
      );

  void onTabSelected(int newIndex) {
    if (_currentlySelectedIndex == newIndex) {
      widget.navigationBarTabs[newIndex].navigatorKey.currentState
          .popUntil((route) => route.isFirst);
    }

    setState(() {
      _currentlySelectedIndex = newIndex;
    });
  }
}
