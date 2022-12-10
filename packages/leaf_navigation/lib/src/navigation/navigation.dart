part of leaf_navigation;

enum LFNavigatorViewState { none, refresh, update, leave }

class LFNavigatorData {
  final LFNavigatorViewState state;
  final dynamic param;

  LFNavigatorData(this.state, {this.param});
}

class LFNavigation {
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

  static Future<T> push<T>(
    BuildContext context, {
    required Widget child,
  }) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => child),
    );
  }

  static Future<T> pushNamed<T>(
    BuildContext context,
    String routeName, {
    required Widget child,
    PageTransitionType? transitionType,
  }) async {
    if (transitionType != null) {
      return await Navigator.push(
        context,
        PageTransition(
          settings: RouteSettings(name: routeName),
          type: transitionType,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      );
    }
    return await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => child,
      ),
    );
  }

  static Future<T> pushAndRemoveUntilNamed<T>(
    BuildContext context,
    String routeName, {
    required Widget child,
  }) async {
    final findIndex = _NavigationHelper.getFindIndexRouteName(routeName);
    var count = 0;

    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => child,
      ),
      (route) {
        count++;
        return _NavigationHelper.getRemoveUntilIndex(route, findIndex, count);
      },
    );
  }

  static void popUntilUntilNamed(BuildContext context, String routeName) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      var shouldPop = false;
      if (route.settings.name == routeName) {
        shouldPop = true;
      }
      return shouldPop;
    });
  }

  static void pop(BuildContext context, {dynamic param}) {
    Navigator.pop(context, param);
  }

  static void maybePop(BuildContext context, {dynamic param}) {
    Navigator.maybePop(context, param);
  }

  static void popRoot(BuildContext context) {
    Navigator.of(context, rootNavigator: true).popUntil((route) {
      return route.isFirst;
    });
  }
}

class LFNavigationBlocProvider {
  /// Push
  static Future<T> push<T>(
    BuildContext context, {
    required MultiBlocProvider provider,
    bool animated = false,
  }) async {
    if (animated) {
      return await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return provider;
          },
          transitionDuration: const Duration(seconds: 0),
        ),
      );
    }
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return provider;
        },
      ),
    );
  }

  static Future<T> pushNamed<T>(
    BuildContext context,
    String routeName, {
    required MultiBlocProvider provider,
    PageTransitionType? transitionType,
  }) async {
    if (transitionType != null) {
      return await Navigator.push(
        context,
        PageRouteBuilder(
          settings: RouteSettings(name: routeName),
          pageBuilder: (_, __, ___) {
            return provider;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (transitionType == PageTransitionType.bottomToTop) {
              final tween =
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
              final position = tween.animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            }
            return child;
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }

    return await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return provider;
        },
      ),
    );
  }

  static Future<T> pushAndRemoveUntilNamed<T>(
    BuildContext context,
    String routeName, {
    required MultiBlocProvider provider,
  }) async {
    final findIndex = _NavigationHelper.getFindIndexRouteName(routeName);
    var count = 0;
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          return provider;
        },
      ),
      (route) {
        count++;
        return _NavigationHelper.getRemoveUntilIndex(route, findIndex, count);
      },
    );
  }
}

class _NavigationHelper {
  static int getFindIndexRouteName(String routeName) {
    var findIndex = 0;
    // final history =
    //     NavigationHistoryObserver().history.toList().reversed.toList();
    // for (var i = 0; i < history.length; i++) {
    //   final route = history[i];
    //   final name = route.settings.name;
    //   if (name == routeName) {
    //     findIndex = i + 1;
    //     break;
    //   }
    // }
    return findIndex;
  }

  static bool getRemoveUntilIndex(
      Route<dynamic> route, int findIndex, int count) {
    // final history =
    //     NavigationHistoryObserver().history.toList().reversed.toList();
    // if (findIndex == 0) {
    //   return history.length - 1 == count;
    // }
    return count == findIndex + 1;
  }
}
