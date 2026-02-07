import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../atoms/badge/widget/lf_badge_v2.dart';
import '../controller/lf_bottom_tab_bar_controller_v2.dart';
import '../model/lf_bottom_tab_item_v2.dart';

/// Callback fired when a tab item is tapped.
typedef LFBottomTabBarOnTapV2 = void Function(
  int selectedIndex,
  bool isAlreadyActive,
);

/// Callback that determines whether a tab selection should be accepted.
typedef LFBottomTabBarOnSelectV2 = Future<bool> Function(
  int selectedIndex,
  int? previousIndex,
  bool isAlreadyActive,
);

/// A themed bottom navigation tab bar.
///
/// Renders a horizontal row of tab items inside a [BottomAppBar].
/// Each item shows an icon, an optional label, and an optional badge.
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LFNavigationBarThemeData] from the nearest [LFTheme]
///   3. Global tokens ([LFColors])
class LFBottomTabBarV2 extends StatelessWidget {
  final LFBottomTabBarControllerV2 controller;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? elevation;
  final double notchMargin;
  final bool visible;
  final LFBottomTabBarOnTapV2? onTap;
  final LFBottomTabBarOnSelectV2? onSelect;

  const LFBottomTabBarV2({
    super.key,
    required this.controller,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.borderRadius,
    this.boxShadow,
    this.shape,
    this.clipBehavior = Clip.none,
    this.padding,
    this.height,
    this.elevation,
    this.notchMargin = 4.0,
    this.visible = true,
    this.onTap,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final colors = theme.colors;
    final navTheme = theme.navigationBarTheme;

    final resolvedBg =
        backgroundColor ?? navTheme?.backgroundColor ?? colors.surface;
    final resolvedSelected =
        selectedColor ?? navTheme?.selectedColor ?? colors.primary;
    final resolvedUnselected =
        unselectedColor ?? navTheme?.unselectedColor ?? colors.inactive;

    return Semantics(
      label: 'Bottom navigation bar',
      child: Visibility(
        visible: visible,
        child: Container(
          decoration: BoxDecoration(boxShadow: boxShadow),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: BottomAppBar(
              elevation: elevation,
              clipBehavior: clipBehavior,
              notchMargin: notchMargin,
              padding: padding,
              height: height,
              color: resolvedBg,
              shape: shape,
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  return _TabRow(
                    items: controller.tabItems,
                    selectedIndex: controller.selectedIndex,
                    selectedColor: resolvedSelected,
                    unselectedColor: resolvedUnselected,
                    labelStyle: navTheme?.labelStyle,
                    onItemTap: _handleItemTap,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleItemTap(int index) {
    final isActive = controller.selectedIndex == index;
    onTap?.call(index, isActive);
  }
}

/// A horizontal row of tab items.
class _TabRow extends StatelessWidget {
  final List<LFBottomTabItemV2> items;
  final int selectedIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? labelStyle;
  final ValueChanged<int> onItemTap;

  const _TabRow({
    required this.items,
    required this.selectedIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.labelStyle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = selectedIndex == index;
          return Expanded(
            child: _TabItem(
              item: item,
              isActive: isActive,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
              labelStyle: labelStyle,
              onTap: () => onItemTap(index),
            ),
          );
        }),
      ],
    );
  }
}

/// A single tab item that renders icon, optional label, and optional badge.
class _TabItem extends StatelessWidget {
  final LFBottomTabItemV2 item;
  final bool isActive;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? labelStyle;
  final VoidCallback onTap;

  const _TabItem({
    required this.item,
    required this.isActive,
    required this.selectedColor,
    required this.unselectedColor,
    required this.labelStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final badgeAlignment =
        item.badgeAlignment ?? const Alignment(1.0, -1.4);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints:
            const BoxConstraints(minHeight: kBottomNavigationBarHeight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIcon(),
                    if (item.label != null) _buildLabel(context),
                  ],
                ),
                if (item.badgeCount > 0)
                  Positioned.fill(
                    child: Align(
                      alignment: badgeAlignment,
                      child: LFBadgeV2(text: item.badgeCount.toString()),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final icon = isActive ? (item.activeIcon ?? item.defaultIcon) : item.defaultIcon;
    if (icon == null) return const SizedBox.shrink();

    if (icon is Icon) {
      final color = isActive ? selectedColor : unselectedColor;
      return Icon(icon.icon, color: color, size: icon.size);
    }
    return icon;
  }

  Widget _buildLabel(BuildContext context) {
    final label = item.label;
    if (label == null) return const SizedBox.shrink();

    final style = isActive
        ? (item.activeLabelStyle ??
            labelStyle?.copyWith(color: selectedColor) ??
            DefaultTextStyle.of(context)
                .style
                .copyWith(color: selectedColor, fontSize: 12.0))
        : (item.defaultLabelStyle ??
            labelStyle?.copyWith(color: unselectedColor) ??
            DefaultTextStyle.of(context)
                .style
                .copyWith(color: unselectedColor, fontSize: 12.0));

    return Text(label, style: style);
  }
}
