/// Represents the index state of a single bottom tab item.
class LFBottomTabIndexV2 {
  final int tabIndex;
  final int activeTabIndex;
  final bool isSelected;

  const LFBottomTabIndexV2({
    required this.tabIndex,
    this.activeTabIndex = 0,
    this.isSelected = false,
  });

  LFBottomTabIndexV2 copyWith({
    int? tabIndex,
    int? activeTabIndex,
    bool? isSelected,
  }) {
    return LFBottomTabIndexV2(
      tabIndex: tabIndex ?? this.tabIndex,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
