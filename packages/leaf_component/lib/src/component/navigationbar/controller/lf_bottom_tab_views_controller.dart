part of '../lf_navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////

mixin LFBottomTabBarViewsMixIn {
  late StreamController<LFBottomTabBarViewsEvent>? streamController;

  int _selectedIndex = 0;
  List<LFBottomTabItem> tabItems = [];

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    updateSelected(selectedIndex: index);
  }

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
    _selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarViewsSelectedEvent(selectedIndex: selectedIndex),
    );
    tabItems = LFBottomTabBarScaffoldController.makeNewItems(tabItems,
        selectedIndex: selectedIndex);
    addEvent(
      LFBottomTabBarViewsItemsEvent(tabItems: tabItems),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

class LFBottomTabBarViewsController with LFBottomTabBarViewsMixIn {
  LFBottomTabBarViewsController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
