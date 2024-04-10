part of '../../leaf_navigation.dart';

class NavigationHelper {
  static bool isExistRoute(BuildContext context, {required String routeName}) {
    bool isCurrent = false;
    Navigator.popUntil(context, (currentRoute) {
      if (currentRoute.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }

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

extension NavigatorStateExtension on NavigatorState {
  bool checkCurrentWithRouteName(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
