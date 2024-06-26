part of '../lf_navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

abstract class LFBottomTabBarEvent {}

class LFBottomTabBarSelectedEvent extends LFBottomTabBarEvent {
  final int selectedIndex;

  LFBottomTabBarSelectedEvent({
    required this.selectedIndex,
  });
}

class LFBottomTabBarItemsEvent extends LFBottomTabBarEvent {
  final List<LFBottomTabItem> tabItems;

  LFBottomTabBarItemsEvent({
    required this.tabItems,
  });
}

class LFBottomTabBarBadgeEvent extends LFBottomTabBarEvent {
  final int tabIndex;
  final bool isNew;

  LFBottomTabBarBadgeEvent({
    required this.tabIndex,
    this.isNew = false,
  });
}

///////////////////////////////////////////////////////////////////////////////

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

  void updateSelected({required int selectedIndex}) {
    _selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarSelectedEvent(selectedIndex: selectedIndex),
    );
    tabItems = LFBottomTabBarScaffoldController.makeNewItems(tabItems,
        selectedIndex: selectedIndex);
    addEvent(
      LFBottomTabBarItemsEvent(tabItems: tabItems),
    );
  }

  void updateTabBadge({required int tabIndex, required bool isNew}) {
    addEvent(
      LFBottomTabBarBadgeEvent(tabIndex: tabIndex, isNew: isNew),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

class LFBottomTabBarController with LFBottomTabBarMixIn {
  LFBottomTabBarController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
