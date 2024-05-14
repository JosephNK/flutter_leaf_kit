part of '../navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

class LFBottomTabBarScaffoldController {
  LFBottomTabBarViewsController tabBarViewsController =
      LFBottomTabBarViewsController();
  LFBottomTabBarController tabBarController = LFBottomTabBarController();

  LFBottomTabBarScaffoldController();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    tabBarViewsController.updateSelected(selectedIndex: index);
    tabBarController.updateSelected(selectedIndex: index);
  }

  void updateTabBadge({required int tabIndex, required bool isNew}) {
    tabBarController.updateTabBadge(tabIndex: tabIndex, isNew: isNew);
  }

  void dispose() {
    tabBarViewsController.dispose();
    tabBarController.dispose();
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
