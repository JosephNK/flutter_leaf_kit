import 'package:flutter/widgets.dart';

import 'lf_bottom_tab_index_v2.dart';

/// Model representing a single bottom navigation tab.
///
/// Holds the visual configuration (icons, label) and
/// selection state ([tabIndex]) for one tab in [LFBottomTabBarV2].
class LFBottomTabItemV2 {
  final LFBottomTabIndexV2 tabIndex;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? label;
  final TextStyle? defaultLabelStyle;
  final TextStyle? activeLabelStyle;
  final int badgeCount;
  final Alignment? badgeAlignment;

  const LFBottomTabItemV2({
    required this.tabIndex,
    required this.defaultIcon,
    this.activeIcon,
    this.label,
    this.defaultLabelStyle,
    this.activeLabelStyle,
    this.badgeCount = 0,
    this.badgeAlignment,
  });

  LFBottomTabItemV2 copyWith({
    LFBottomTabIndexV2? tabIndex,
    Widget? defaultIcon,
    Widget? activeIcon,
    String? label,
    TextStyle? defaultLabelStyle,
    TextStyle? activeLabelStyle,
    int? badgeCount,
    Alignment? badgeAlignment,
  }) {
    return LFBottomTabItemV2(
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
