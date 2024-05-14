part of '../navigationbar.dart';

class LFBottomTabIndex {
  final int tabIndex;
  final int activeTabIndex;
  final bool didSelected;
  final bool forceActive;

  LFBottomTabIndex({
    required this.tabIndex,
    this.activeTabIndex = 0,
    this.didSelected = false,
    this.forceActive = false,
  });

  LFBottomTabIndex copyWith({
    int Function()? tabIndex,
    int Function()? activeTabIndex,
    bool Function()? didSelected,
    bool Function()? forceActive,
  }) {
    return LFBottomTabIndex(
      tabIndex: tabIndex != null ? tabIndex() : this.tabIndex,
      activeTabIndex:
          activeTabIndex != null ? activeTabIndex() : this.activeTabIndex,
      didSelected: didSelected != null ? didSelected() : this.didSelected,
      forceActive: forceActive != null ? forceActive() : this.forceActive,
    );
  }
}
