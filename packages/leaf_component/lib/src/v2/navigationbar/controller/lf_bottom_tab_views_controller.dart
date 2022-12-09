part of lf_navigationbar;

abstract class LFBottomTabBarViewsEvent {}

class LFBottomTabBarViewsSelectedEvent extends LFBottomTabBarViewsEvent {
  final int selectedIndex;

  LFBottomTabBarViewsSelectedEvent({
    required this.selectedIndex,
  });
}

class LFBottomTabBarViewsItemsEvent extends LFBottomTabBarViewsEvent {
  final List<LFBottomTabItem> tabItems;

  LFBottomTabBarViewsItemsEvent({
    required this.tabItems,
  });
}

mixin LFBottomTabBarViewsMixIn {
  late StreamController<LFBottomTabBarViewsEvent>? streamController;

  int selectedIndex = 0;
  List<LFBottomTabItem> tabItems = [];

  void init() {
    streamController = StreamController<LFBottomTabBarViewsEvent>.broadcast();
  }

  void tearDown() {
    streamController?.close();
  }

  void addEvent(LFBottomTabBarViewsEvent value) {
    streamController?.sink.add(value);
  }

  void updateSelected({required int selectedIndex}) {
    this.selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarViewsSelectedEvent(selectedIndex: selectedIndex),
    );
  }

  void updateTabItems({required List<LFBottomTabItem> tabItems}) {
    this.tabItems = tabItems;
    addEvent(
      LFBottomTabBarViewsItemsEvent(tabItems: tabItems),
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

class LFBottomTabBarViewsController with LFBottomTabBarViewsMixIn {
  LFBottomTabBarViewsController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
