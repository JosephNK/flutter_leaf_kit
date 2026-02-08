import 'package:flutter/material.dart';

import '../controller/leaf_bottom_tab_bar_controller.dart';
import '../model/leaf_bottom_tab_item.dart';

/// Builder that creates child views from the current tab items.
typedef LeafBottomTabViewsBuilder =
    List<Widget> Function(List<LeafBottomTabItem> tabItems);

/// Displays the content view for the currently selected tab.
///
/// Uses [IndexedStack] to preserve each tab's state while only
/// showing the currently selected one.
class LeafBottomTabViews extends StatelessWidget {
  final LeafBottomTabBarController controller;
  final LeafBottomTabViewsBuilder builder;

  const LeafBottomTabViews({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Tab content views',
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final children = builder(controller.tabItems);
          return IndexedStack(
            index: controller.selectedIndex,
            children: children,
          );
        },
      ),
    );
  }
}
