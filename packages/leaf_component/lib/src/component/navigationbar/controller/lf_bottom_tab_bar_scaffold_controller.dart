part of '../navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

class LFBottomTabBarScaffoldController {
  LFBottomTabBarViewsController tabBarViewsController =
      LFBottomTabBarViewsController();
  LFBottomTabBarController tabBarController = LFBottomTabBarController();
  StreamController<int> streamController = StreamController<int>.broadcast();

  LFBottomTabBarScaffoldController();

  int _previousIndex = 0;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    tabBarViewsController.updateSelected(selectedIndex: index);
    tabBarController.updateSelected(selectedIndex: index);
    addChangeIndexEvent(index);
  }

  void updateTabBadge({required int tabIndex, required bool isNew}) {
    tabBarController.updateTabBadge(tabIndex: tabIndex, isNew: isNew);
  }

  StreamSubscription<int> addSubscription(void Function(int event) onData) {
    return streamController.stream.listen(onData);
  }

  void addChangeIndexEvent(int index) {
    if (_previousIndex == index) {
      return;
    }
    _previousIndex = index;
    streamController.sink.add(index);
  }

  void dispose() {
    tabBarViewsController.dispose();
    tabBarController.dispose();
    streamController.close();
  }

  static List<LFBottomTabItem> makeNewItems(
    List<LFBottomTabItem> tabItems, {
    required int selectedIndex,
  }) {
    return tabItems.asMap().entries.map((e) {
      final index = e.key;
      final item = e.value;
      final didSelected = (selectedIndex == index);
      return item.copyWith(
          bottomTabIndex: item.bottomTabIndex.copyWith(
        activeTabIndex: () => selectedIndex,
        didSelected: () =>
            (index == item.bottomTabIndex.tabIndex) ? didSelected : false,
      ));
    }).toList();
  }
}
