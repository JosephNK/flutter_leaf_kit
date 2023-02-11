part of leaf_navigation;

enum LFNavigatorParamState { flow }

class LFNavigation {
  /// Pop
  static void popUntilUntilNamed(BuildContext context, String routeName) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      var shouldPop = false;
      if (route.settings.name == routeName) {
        shouldPop = true;
      }
      return shouldPop;
    });
  }

  static void popUntilDepth(BuildContext context, {required int depth}) {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= depth);
  }

  static NavigatorState pop(BuildContext context, {dynamic param}) {
    NavigatorState navigator = Navigator.of(context);
    navigator.pop(param);
    return navigator;
  }

  static Future<bool> maybePop(BuildContext context, {dynamic param}) {
    return Navigator.maybePop(context, param);
  }

  static void popRoot(BuildContext context) {
    Navigator.of(context, rootNavigator: true).popUntil((route) {
      return route.isFirst;
    });
  }

  /// Push
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    required Widget child, // Widget, MultiBlocProvider
    bool isUsingIosModalType = false,
    bool fullscreenDialog = false,
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
    late PageRoute<T> route;
    if (!isUsingIosModalType) {
      route = MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return child;
        },
      );
    } else {
      route = MaterialWithModalsPageRoute(
        settings: routeSettings,
        fullscreenDialog: fullscreenDialog,
        builder: (context) {
          return child;
        },
      );
    }
    return await Navigator.push(context, route);
  }
}
