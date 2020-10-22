import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_advisor/presentation/adaptive/bottom_navigation/bottom_navigation_tab.dart';

class MaterialBottomNavigationScaffold extends StatefulWidget {
  const MaterialBottomNavigationScaffold({
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
  _MaterialBottomNavigationScaffoldState createState() =>
      _MaterialBottomNavigationScaffoldState();
}

class _MaterialBottomNavigationScaffoldState
    extends State<MaterialBottomNavigationScaffold>
    with TickerProviderStateMixin<MaterialBottomNavigationScaffold> {
  final List<_MaterialBottomNavigationTab> materialNavigationBarTabs = [];
  final List<AnimationController> _animationControllers = [];

  final List<bool> _shouldBuildTab = <bool>[];

  @override
  void initState() {
    _initAnimationControllers();
    _initMaterialNavigationBarItems();

    _shouldBuildTab.addAll(List<bool>.filled(
      widget.navigationBarTabs.length,
      false,
    ));

    super.initState();
  }

  void _initMaterialNavigationBarItems() {
    materialNavigationBarTabs.addAll(
      widget.navigationBarTabs
          .map(
            (barItem) => _MaterialBottomNavigationTab(
              bottomNavigationBarItem: barItem.bottomNavigationBarItem,
              navigatorKey: barItem.navigatorKey,
              subtreeKey: GlobalKey(),
              initialPageBuilder: barItem.initialPageBuilder,
            ),
          )
          .toList(),
    );
  }

  void _initAnimationControllers() {
    _animationControllers.addAll(
      widget.navigationBarTabs.map<AnimationController>(
        (destination) => AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );

    if (_animationControllers.isNotEmpty) {
      _animationControllers[0].value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationControllers.forEach(
      (controller) => controller.dispose(),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: materialNavigationBarTabs.map((barItem) {
            final tabIndex = materialNavigationBarTabs.indexOf(barItem);
            final isCurrentlySelected = tabIndex == widget.selectedIndex;

            // We should build the tab content only if it was already built or
            // if it is currently selected.
            _shouldBuildTab[tabIndex] =
                isCurrentlySelected || _shouldBuildTab[tabIndex];

            return _FadePageFlow(
                item: barItem,
                shouldBuildTab: _shouldBuildTab[tabIndex],
                animationController: _animationControllers[tabIndex],
                isCurrentlySelected: isCurrentlySelected);
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          items: materialNavigationBarTabs
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: widget.onItemSelected,
        ),
      );

}

class _FadePageFlow extends StatelessWidget {
  const _FadePageFlow({
    @required this.item,
    @required this.shouldBuildTab,
    @required this.animationController,
    @required this.isCurrentlySelected,
  })  : assert(item != null),
        assert(shouldBuildTab != null),
        assert(animationController != null),
        assert(isCurrentlySelected != null);

  final _MaterialBottomNavigationTab item;
  final bool shouldBuildTab;
  final AnimationController animationController;
  final bool isCurrentlySelected;

  @override
  Widget build(BuildContext context) {
    final Widget view = FadeTransition(
      opacity: animationController.drive(
        CurveTween(curve: Curves.fastOutSlowIn),
      ),
      child: _PageFlow(
        item: item,
        shouldBuildTab: shouldBuildTab,
      ),
    );
    if (isCurrentlySelected) {
      animationController.forward();
      return view;
    } else {
      animationController.reverse();
      if (animationController.isAnimating) {
        return IgnorePointer(child: view);
      }
      return Offstage(child: view);
    }
  }
}

class _PageFlow extends StatelessWidget {
  const _PageFlow({
    @required this.item,
    @required this.shouldBuildTab,
  })  : assert(item != null),
        assert(shouldBuildTab != null);

  final bool shouldBuildTab;
  final _MaterialBottomNavigationTab item;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
        key: item.subtreeKey,
        child: shouldBuildTab
            ? Navigator(
                // The key enables us to access the Navigator's state inside the
                // onWillPop callback and for emptying its stack when a tab is
                // re-selected. That is why a GlobalKey is needed instead of
                // a simpler ValueKey.
                key: item.navigatorKey,
                // The onGenerateRoute callback will be called only for the
                // initial route.
                onGenerateRoute: (settings) => MaterialPageRoute(
                  settings: settings,
                  builder: item.initialPageBuilder,
                ),
              )
            : Container(),
      );
}

/// Extension class of BottomNavigationTab that adds another GlobalKey to it
/// in order to use it within the KeyedSubtree widget.
class _MaterialBottomNavigationTab extends BottomNavigationTab {
  const _MaterialBottomNavigationTab({
    @required BottomNavigationBarItem bottomNavigationBarItem,
    @required GlobalKey<NavigatorState> navigatorKey,
    @required WidgetBuilder initialPageBuilder,
    @required this.subtreeKey,
  })  : assert(bottomNavigationBarItem != null),
        assert(subtreeKey != null),
        assert(initialPageBuilder != null),
        assert(navigatorKey != null),
        super(
          bottomNavigationBarItem: bottomNavigationBarItem,
          navigatorKey: navigatorKey,
          initialPageBuilder: initialPageBuilder,
        );

  final GlobalKey subtreeKey;
}

/*
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: materialNavigationBarTabs
              .map(
                (barItem) => _buildPageFlow(
                  context,
                  materialNavigationBarTabs.indexOf(barItem),
                  barItem,
                ),
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          items: materialNavigationBarTabs
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: widget.onItemSelected,
        ),
      );

  Widget _buildPageFlow(
    BuildContext context,
    int tabIndex,
    _MaterialBottomNavigationTab item,
  ) {
    final isCurrentlySelected = tabIndex == widget.selectedIndex;

    // We should build the tab content only if it was already built or
    // if it is currently selected.
    _shouldBuildTab[tabIndex] =
        isCurrentlySelected || _shouldBuildTab[tabIndex];

    final Widget view = FadeTransition(
      opacity: _animationControllers[tabIndex].drive(
        CurveTween(curve: Curves.fastOutSlowIn),
      ),
      child: KeyedSubtree(
        key: item.subtreeKey,
        child: _shouldBuildTab[tabIndex]
            ? Navigator(
                // The key enables us to access the Navigator's state inside the
                // onWillPop callback and for emptying its stack when a tab is
                // re-selected. That is why a GlobalKey is needed instead of
                // a simpler ValueKey.
                key: item.navigatorKey,
                // The onGenerateRoute callback will be called only for the initial
                // route.
                onGenerateRoute: (settings) => MaterialPageRoute(
                  settings: settings,
                  builder: item.initialPageBuilder,
                ),
              )
            : Container(),
      ),
    );

    if (tabIndex == widget.selectedIndex) {
      _animationControllers[tabIndex].forward();
      return view;
    } else {
      _animationControllers[tabIndex].reverse();
      if (_animationControllers[tabIndex].isAnimating) {
        return IgnorePointer(child: view);
      }
      return Offstage(child: view);
    }
  }
*/
