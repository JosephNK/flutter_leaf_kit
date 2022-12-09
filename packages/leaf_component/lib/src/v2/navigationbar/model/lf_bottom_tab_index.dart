part of lf_navigationbar;

class LFBottomTabIndex {
  final int tabIndex;
  final int activeTabIndex;
  final bool didSelected;

  LFBottomTabIndex({
    required this.tabIndex,
    this.activeTabIndex = 0,
    this.didSelected = false,
  });

  LFBottomTabIndex copyWith({
    int? tabIndex,
    int? activeTabIndex,
    bool? didSelected,
  }) {
    return LFBottomTabIndex(
      tabIndex: tabIndex ?? this.tabIndex,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      didSelected: didSelected ?? this.didSelected,
    );
  }
}
