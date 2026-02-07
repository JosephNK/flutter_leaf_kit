part of '../navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
abstract class LFBottomTabBarEvent {}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarSelectedEvent extends LFBottomTabBarEvent {
  final int selectedIndex;
  final int? previousIndex;

  LFBottomTabBarSelectedEvent({
    required this.selectedIndex,
    this.previousIndex,
  });
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarItemsEvent extends LFBottomTabBarEvent {
  final List<LFBottomTabItem> tabItems;

  LFBottomTabBarItemsEvent({
    required this.tabItems,
  });
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarBadgeEvent extends LFBottomTabBarEvent {
  final List<LFBottomTabItem> tabItems;
  final int tabIndex;
  final int badgeCount;

  LFBottomTabBarBadgeEvent({
    required this.tabItems,
    required this.tabIndex,
    this.badgeCount = 0,
  });
}

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
mixin LFBottomTabBarMixIn {
  late StreamController<LFBottomTabBarEvent>? streamController;

  int _selectedIndex = 0;
  List<LFBottomTabItem> tabItems = [];

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    updateSelected(selectedIndex: index);
  }

  void init() {
    streamController = StreamController<LFBottomTabBarEvent>.broadcast();
  }

  void tearDown() {
    streamController?.close();
  }

  void addEvent(LFBottomTabBarEvent value) {
    streamController?.sink.add(value);
  }

  void updateSelected({required int selectedIndex, int? previousIndex}) {
    _selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarSelectedEvent(
        selectedIndex: selectedIndex,
        previousIndex: previousIndex,
      ),
    );
    tabItems = LFBottomTabBarScaffoldController.makeNewItems(
      tabItems,
      selectedIndex: selectedIndex,
    );
    addEvent(
      LFBottomTabBarItemsEvent(
        tabItems: tabItems,
      ),
    );
  }

  void updateTabBadge({required int tabIndex, required int badgeCount}) {
    tabItems = LFBottomTabBarScaffoldController.makeUpdateBadgeItems(
      tabItems,
      selectedIndex: selectedIndex,
      badgeCount: badgeCount,
    );
    addEvent(
      LFBottomTabBarBadgeEvent(
        tabItems: tabItems,
        tabIndex: tabIndex,
        badgeCount: badgeCount,
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarController with LFBottomTabBarMixIn {
  LFBottomTabBarController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
