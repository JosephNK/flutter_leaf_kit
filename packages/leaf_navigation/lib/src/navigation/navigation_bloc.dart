part of '../../leaf_navigation.dart';

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

  @Deprecated('Use LFNavigation.pushNamed')
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    required MultiBlocProvider provider,
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
          return provider;
        },
      );
    }
    late PageRoute<T> route;
    if (!isUsingIosModalType) {
      route = MaterialPageRoute(
        settings: routeSettings,
        builder: (context) {
          return provider;
        },
      );
    } else {
      route = MaterialWithModalsPageRoute(
        settings: routeSettings,
        fullscreenDialog: fullscreenDialog,
        builder: (context) {
          return provider;
        },
      );
    }
    return await Navigator.push(context, route);
  }

  static Future<T> pushNamedAtTransition<T>(
    BuildContext context,
    String routeName, {
    required MultiBlocProvider provider,
    required PageTransitionType transitionType,
  }) async {
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

  static Future<T> pushAndRemoveUntilNamed<T>(
    BuildContext context,
    String routeName, {
    required MultiBlocProvider provider,
  }) async {
    final findIndex = NavigationHelper.getFindIndexRouteName(routeName);
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
        return NavigationHelper.getRemoveUntilIndex(route, findIndex, count);
      },
    );
  }
}
