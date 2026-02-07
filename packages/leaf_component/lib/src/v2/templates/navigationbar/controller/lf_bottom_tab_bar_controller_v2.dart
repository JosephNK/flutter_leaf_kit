import 'package:flutter/foundation.dart';

import '../model/lf_bottom_tab_item_v2.dart';

/// Unified controller for the bottom tab bar navigation system.
///
/// Consolidates V1's three separate stream-based controllers into a single
/// [ChangeNotifier]. Manages tab selection, tab items, and badge updates.
///
/// Usage:
/// ```dart
/// final controller = LFBottomTabBarControllerV2();
/// controller.setItems(items, selectedIndex: 0);
/// controller.selectedIndex = 2; // switches to tab 2
/// controller.updateBadge(tabIndex: 1, badgeCount: 5);
/// ```
class LFBottomTabBarControllerV2 extends ChangeNotifier {
  int _selectedIndex;
  int _previousIndex;
  List<LFBottomTabItemV2> _tabItems;

  LFBottomTabBarControllerV2({
    int initialIndex = 0,
  })  : _selectedIndex = initialIndex,
        _previousIndex = initialIndex,
        _tabItems = const [];

  /// The currently selected tab index.
  int get selectedIndex => _selectedIndex;

  /// The previously selected tab index.
  int get previousIndex => _previousIndex;

  /// The current list of tab items with their selection states.
  List<LFBottomTabItemV2> get tabItems => _tabItems;

  /// Sets the selected index and notifies listeners.
  set selectedIndex(int index) {
    if (index < 0 || (tabItems.isNotEmpty && index >= tabItems.length)) return;
    _previousIndex = _selectedIndex;
    _selectedIndex = index;
    _tabItems = _rebuildItems(_tabItems, selectedIndex: index);
    notifyListeners();
  }

  /// Initialises or replaces all tab items and sets the active index.
  void setItems(
    List<LFBottomTabItemV2> items, {
    required int selectedIndex,
  }) {
    _selectedIndex = selectedIndex;
    _previousIndex = selectedIndex;
    _tabItems = _rebuildItems(items, selectedIndex: selectedIndex);
    notifyListeners();
  }

  /// Updates the badge count for the tab at [tabIndex].
  void updateBadge({required int tabIndex, required int badgeCount}) {
    _tabItems = _tabItems.map((item) {
      if (item.tabIndex.tabIndex == tabIndex) {
        return item.copyWith(badgeCount: badgeCount);
      }
      return item;
    }).toList();
    notifyListeners();
  }

  /// Rebuilds item selection states based on [selectedIndex].
  static List<LFBottomTabItemV2> _rebuildItems(
    List<LFBottomTabItemV2> items, {
    required int selectedIndex,
  }) {
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return item.copyWith(
        tabIndex: item.tabIndex.copyWith(
          activeTabIndex: selectedIndex,
          isSelected: index == selectedIndex,
        ),
      );
    }).toList();
  }
}
