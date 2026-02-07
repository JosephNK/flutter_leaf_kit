import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';

@immutable
class LeafTabBar extends StatelessWidget {
  final TabController? controller;
  final List<Tab> tabs;
  final bool isScrollable;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? indicatorColor;
  final Color? dividerColor;
  final EdgeInsets? indicatorPadding;
  final EdgeInsets? labelPadding;
  final WidgetStateProperty<Color?>? overlayColor;
  final TabBarIndicatorSize? indicatorSize;
  final ValueChanged<int>? onTap;

  const LeafTabBar({
    super.key,
    this.controller,
    required this.tabs,
    this.isScrollable = false,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorColor,
    this.dividerColor,
    this.indicatorPadding,
    this.labelPadding,
    this.overlayColor,
    this.indicatorSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final tabBarTheme = theme.tabBarTheme;

    final resolvedLabelColor =
        labelColor ?? tabBarTheme?.labelColor ?? colors.primary;
    final resolvedUnselectedLabelColor =
        unselectedLabelColor ??
        tabBarTheme?.unselectedLabelColor ??
        colors.inactive;
    final resolvedLabelStyle = labelStyle ?? tabBarTheme?.labelStyle;
    final resolvedUnselectedLabelStyle =
        unselectedLabelStyle ?? tabBarTheme?.unselectedLabelStyle;
    final resolvedIndicatorColor =
        indicatorColor ?? tabBarTheme?.indicatorColor ?? colors.primary;
    final resolvedDividerColor =
        dividerColor ?? tabBarTheme?.dividerColor ?? colors.divider;
    final resolvedIndicatorPadding =
        indicatorPadding ?? tabBarTheme?.indicatorPadding;
    final resolvedLabelPadding =
        labelPadding ?? tabBarTheme?.labelPadding;

    return Semantics(
      label: 'Tab bar',
      child: TabBar(
        controller: controller,
        tabs: tabs,
        isScrollable: isScrollable,
        labelColor: resolvedLabelColor,
        unselectedLabelColor: resolvedUnselectedLabelColor,
        labelStyle: resolvedLabelStyle,
        unselectedLabelStyle: resolvedUnselectedLabelStyle,
        indicatorColor: resolvedIndicatorColor,
        dividerColor: resolvedDividerColor,
        indicatorPadding: resolvedIndicatorPadding ?? EdgeInsets.zero,
        labelPadding: resolvedLabelPadding,
        overlayColor: overlayColor,
        indicatorSize: indicatorSize,
        onTap: onTap,
      ),
    );
  }
}
