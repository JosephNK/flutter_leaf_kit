import 'package:flutter/material.dart';

import '../controller/lf_bottom_tab_bar_controller_v2.dart';
import '../model/lf_bottom_tab_item_v2.dart';

/// Builder that creates child views from the current tab items.
typedef LFBottomTabViewsBuilderV2 = List<Widget> Function(
  List<LFBottomTabItemV2> tabItems,
);

/// Displays the content view for the currently selected tab.
///
/// Uses [IndexedStack] to preserve each tab's state while only
/// showing the currently selected one.
class LFBottomTabViewsV2 extends StatelessWidget {
  final LFBottomTabBarControllerV2 controller;
  final LFBottomTabViewsBuilderV2 builder;

  const LFBottomTabViewsV2({
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
