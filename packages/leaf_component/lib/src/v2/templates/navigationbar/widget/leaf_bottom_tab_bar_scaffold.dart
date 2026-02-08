import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../controller/leaf_bottom_tab_bar_controller.dart';
import '../model/leaf_bottom_tab_item.dart';
import 'leaf_bottom_tab_bar.dart';
import 'leaf_bottom_tab_views.dart';

/// A scaffold that combines [LeafBottomTabBar] and [LeafBottomTabViews].
///
/// Provides an all-in-one bottom tab bar navigation layout. On first build
/// it initialises the [controller] with the provided [tabItems] and
/// [selectedIndex].
///
/// Style resolution order:
///   1. Explicit widget parameters
///   2. [LeafNavigationBarThemeData] from the nearest [LeafTheme]
///   3. Global tokens ([LeafColors])
class LeafBottomTabBarScaffold extends StatefulWidget {
  final LeafBottomTabBarController controller;
  final List<LeafBottomTabItem> tabItems;
  final int selectedIndex;
  final List<int> deactivateIndexes;
  final LeafBottomTabViewsBuilder viewBuilder;
  final PreferredSizeWidget? appBar;
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
  final bool showTabBar;
  final LeafBottomTabBarOnSelect? onSelect;

  const LeafBottomTabBarScaffold({
    super.key,
    required this.controller,
    required this.tabItems,
    required this.viewBuilder,
    this.selectedIndex = 0,
    this.deactivateIndexes = const [],
    this.appBar,
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
    this.showTabBar = true,
    this.onSelect,
  });

  @override
  State<LeafBottomTabBarScaffold> createState() =>
      _LeafBottomTabBarScaffoldState();
}

class _LeafBottomTabBarScaffoldState extends State<LeafBottomTabBarScaffold> {
  @override
  void initState() {
    super.initState();
    widget.controller.setItems(
      widget.tabItems,
      selectedIndex: widget.selectedIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Tab bar scaffold',
      child: Scaffold(
        appBar: widget.appBar,
        backgroundColor: Colors.transparent,
        body: LeafBottomTabViews(
          controller: widget.controller,
          builder: widget.viewBuilder,
        ),
        bottomNavigationBar: LeafBottomTabBar(
          controller: widget.controller,
          backgroundColor: widget.backgroundColor,
          selectedColor: widget.selectedColor,
          unselectedColor: widget.unselectedColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
          shape: widget.shape,
          clipBehavior: widget.clipBehavior,
          padding: widget.padding,
          height: widget.height,
          elevation: widget.elevation,
          notchMargin: widget.notchMargin,
          visible: widget.showTabBar,
          onTap: _handleTap,
        ),
      ),
    );
  }

  Future<void> _handleTap(int index, bool isAlreadyActive) async {
    if (widget.deactivateIndexes.contains(index)) return;

    final shouldSelect =
        await widget.onSelect?.call(
          index,
          widget.controller.previousIndex,
          isAlreadyActive,
        ) ??
        true;

    if (shouldSelect) {
      widget.controller.selectedIndex = index;
    }
  }
}
