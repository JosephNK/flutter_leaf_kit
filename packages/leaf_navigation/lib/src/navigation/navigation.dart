part of leaf_navigation;

enum LFNavigatorParamState { flow }

enum LFNavigatorPushType {
  basicMaterial,
  basicCupertino,
  basicCupertinoFullScreen,
  materialModal,
  cupertinoModal
}

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

  static NavigatorState pop<T>(BuildContext context, {T? param}) {
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
    LFNavigatorPushType pushType = LFNavigatorPushType.basicCupertino,
  }) async {
    Logging.i('[LFNavigation PushNamed] PushType :: $routeName => $pushType');

    RouteSettings routeSettings = RouteSettings(name: routeName);

    switch (pushType) {
      case LFNavigatorPushType.basicMaterial:
        PageRoute<T> route = MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            return child;
          },
        );
        return await Navigator.push(context, route);
      case LFNavigatorPushType.basicCupertino:
      case LFNavigatorPushType.basicCupertinoFullScreen:
        PageRoute<T> route = MaterialWithModalsPageRoute(
          settings: routeSettings,
          fullscreenDialog:
              (pushType == LFNavigatorPushType.basicCupertinoFullScreen),
          builder: (context) {
            return child;
          },
        );
        return await Navigator.push(context, route);
      case LFNavigatorPushType.materialModal:
        return await Navigator.push(
          context,
          PageRouteBuilder(
            settings: routeSettings,
            pageBuilder: (_, __, ___) {
              return child;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final tween =
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
              final position = tween.animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      case LFNavigatorPushType.cupertinoModal:
        return await showCupertinoModalBottomSheet(
          context: context,
          settings: routeSettings,
          builder: (context) {
            return child;
          },
        );
    }
  }
}
