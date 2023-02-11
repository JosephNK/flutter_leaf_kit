part of leaf_navigation;

class LFNavigationBasic {
  /// Push
  static Future<T> push<T>(
    BuildContext context, {
    required Widget child,
  }) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => child),
    );
  }

  @Deprecated('Use LFNavigation.pushNamed')
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    required Widget child,
    PageTransitionType? transitionType,
    bool isShowModal = false,
  }) async {
    RouteSettings routeSettings = RouteSettings(name: routeName);
    if (isShowModal) {
      return await showCupertinoModalBottomSheet(
        context: context,
        settings: routeSettings,
        builder: (context) {
          return child;
        },
      );
    }
    if (transitionType != null) {
      return await Navigator.push(
        context,
        PageTransition(
          settings: routeSettings,
          type: transitionType,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      );
    }
    return await Navigator.push(
      context,
      MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => child,
      ),
    );
  }

  static Future<T> pushAndRemoveUntilNamed<T>(
    BuildContext context,
    String routeName, {
    required Widget child,
  }) async {
    final findIndex = NavigationHelper.getFindIndexRouteName(routeName);
    var count = 0;

    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => child,
      ),
      (route) {
        count++;
        return NavigationHelper.getRemoveUntilIndex(route, findIndex, count);
      },
    );
  }

  /// Modal (not used)
  static void presentModal(
    BuildContext context, {
    required GlobalKey<NavigatorState> navigatorKey,
    required Widget widget,
  }) {
    // nested navigation
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Navigator(
          key: navigatorKey,
          onGenerateRoute: (route) => MaterialPageRoute(
            settings: route,
            builder: (context) => widget,
          ),
        );
      },
      fullscreenDialog: true,
    ));
  }
}
