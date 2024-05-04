import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final String title;

  const BottomNavigationBarScreen({
    super.key,
    required this.title,
  });

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final LFBottomTabBarScaffoldController _bottomTabBarScaffoldController =
      LFBottomTabBarScaffoldController();

  final List<LFBottomTabItem> _tabItems = [
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 0),
      defaultIcon: const Icon(Icons.home),
      text: 'Home',
      isNew: false,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 1),
      defaultIcon: const Icon(Icons.feed),
      text: 'Feed',
      isNew: false,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 2),
      defaultIcon: const Icon(Icons.settings),
      text: 'Setup',
      isNew: true,
    ),
  ];

  @override
  void dispose() {
    _bottomTabBarScaffoldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LFBottomTabBarScaffold(
      appBar: LFAppBar(
        title: LFAppBarTitle(text: widget.title),
        actions: [
          LFAppBarAction(
            icon: const Icon(Icons.home),
            onPressed: () {},
          )
        ],
      ),
      scaffoldController: _bottomTabBarScaffoldController,
      tabItems: _tabItems,
      selectedIndex: 0,
      children: (tabItems) {
        return [
          ...[0, 1, 2].map((e) {
            return Container(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: GestureDetector(
                onTap: () {
                  const i = 2;
                  _bottomTabBarScaffoldController.updateTabBadge(
                    tabIndex: i,
                    isNew: !tabItems[i].isNew,
                  );
                },
                child: Center(
                  child: Text('Button $e'),
                ),
              ),
            );
          }),
        ];
      },
      onPressed: (index) {
        _bottomTabBarScaffoldController.selectedIndex = index;
      },
    );
  }
}
