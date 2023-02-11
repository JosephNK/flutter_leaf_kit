part of leaf_navigation;

class NavigationHelper {
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
