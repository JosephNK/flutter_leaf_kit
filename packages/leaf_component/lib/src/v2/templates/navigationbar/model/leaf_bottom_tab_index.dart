/// Represents the index state of a single bottom tab item.
class LeafBottomTabIndex {
  final int tabIndex;
  final int activeTabIndex;
  final bool isSelected;

  const LeafBottomTabIndex({
    required this.tabIndex,
    this.activeTabIndex = 0,
    this.isSelected = false,
  });

  LeafBottomTabIndex copyWith({
    int? tabIndex,
    int? activeTabIndex,
    bool? isSelected,
  }) {
    return LeafBottomTabIndex(
      tabIndex: tabIndex ?? this.tabIndex,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
