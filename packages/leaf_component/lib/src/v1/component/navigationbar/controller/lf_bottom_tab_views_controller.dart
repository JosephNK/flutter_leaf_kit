part of '../navigationbar.dart';

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
abstract class LFBottomTabBarViewsEvent {}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarViewsSelectedEvent extends LFBottomTabBarViewsEvent {
  final int selectedIndex;
  final int? previousIndex;

  LFBottomTabBarViewsSelectedEvent({
    required this.selectedIndex,
    this.previousIndex,
  });
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarViewsItemsEvent extends LFBottomTabBarViewsEvent {
  final List<LFBottomTabItem> tabItems;

  LFBottomTabBarViewsItemsEvent({required this.tabItems});
}

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
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

  void updateSelected({required int selectedIndex, int? previousIndex}) {
    _selectedIndex = selectedIndex;
    addEvent(
      LFBottomTabBarViewsSelectedEvent(
        selectedIndex: selectedIndex,
        previousIndex: previousIndex,
      ),
    );
    tabItems = LFBottomTabBarScaffoldController.makeNewItems(
      tabItems,
      selectedIndex: selectedIndex,
    );
    addEvent(LFBottomTabBarViewsItemsEvent(tabItems: tabItems));
  }
}

///////////////////////////////////////////////////////////////////////////////

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFBottomTabBarViewsController with LFBottomTabBarViewsMixIn {
  LFBottomTabBarViewsController() {
    init();
  }

  void dispose() {
    tearDown();
  }
}
