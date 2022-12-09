part of lf_navigationbar;

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

mixin LFBottomTabBarMixIn {
  late StreamController<LFBottomTabBarEvent>? streamController;

  int selectedIndex = 0;
  List<LFBottomTabItem> tabItems = [];

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
    this.selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarSelectedEvent(selectedIndex: selectedIndex),
    );
  }

  void updateTabItems({required List<LFBottomTabItem> tabItems}) {
    this.tabItems = tabItems;
    addEvent(
      LFBottomTabBarItemsEvent(tabItems: tabItems),
    );
  }

  void updateTabBadge({required int tabIndex, required bool isNew}) {
    addEvent(
      LFBottomTabBarBadgeEvent(tabIndex: tabIndex, isNew: isNew),
    );
  }

  void updateTabSelectedWithTabItems({
    required int selectedIndex,
    required List<LFBottomTabItem> tabItems,
  }) {
    updateSelected(selectedIndex: selectedIndex);
    updateTabItems(tabItems: tabItems);
  }
}

class LFBottomTabBarController with LFBottomTabBarMixIn {
  LFBottomTabBarController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
