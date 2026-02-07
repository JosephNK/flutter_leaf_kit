import 'package:flutter/widgets.dart';

import 'leaf_bottom_tab_index.dart';

/// Model representing a single bottom navigation tab.
///
/// Holds the visual configuration (icons, label) and
/// selection state ([tabIndex]) for one tab in [LeafBottomTabBar].
class LeafBottomTabItem {
  final LeafBottomTabIndex tabIndex;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? label;
  final TextStyle? defaultLabelStyle;
  final TextStyle? activeLabelStyle;
  final int badgeCount;
  final Alignment? badgeAlignment;

  const LeafBottomTabItem({
    required this.tabIndex,
    required this.defaultIcon,
    this.activeIcon,
    this.label,
    this.defaultLabelStyle,
    this.activeLabelStyle,
    this.badgeCount = 0,
    this.badgeAlignment,
  });

  LeafBottomTabItem copyWith({
    LeafBottomTabIndex? tabIndex,
    Widget? defaultIcon,
    Widget? activeIcon,
    String? label,
    TextStyle? defaultLabelStyle,
    TextStyle? activeLabelStyle,
    int? badgeCount,
    Alignment? badgeAlignment,
  }) {
    return LeafBottomTabItem(
      tabIndex: tabIndex ?? this.tabIndex,
      defaultIcon: defaultIcon ?? this.defaultIcon,
      activeIcon: activeIcon ?? this.activeIcon,
      label: label ?? this.label,
      defaultLabelStyle: defaultLabelStyle ?? this.defaultLabelStyle,
      activeLabelStyle: activeLabelStyle ?? this.activeLabelStyle,
      badgeCount: badgeCount ?? this.badgeCount,
      badgeAlignment: badgeAlignment ?? this.badgeAlignment,
    );
  }
}
