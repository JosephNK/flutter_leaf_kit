import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final String title;

  const BottomNavigationBarScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final LFBottomTabBarViewsController _bottomTabBarViewsController =
      LFBottomTabBarViewsController();
  final LFBottomTabBarController _bottomTabBarController =
      LFBottomTabBarController();

  final List<LFBottomTabItem> _tabItems = [
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 0),
      icon: const Icon(Icons.home),
      text: 'Home',
      isNew: false,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 1),
      icon: const Icon(Icons.feed),
      text: 'Feed',
      isNew: false,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 2),
      icon: const Icon(Icons.settings),
      text: 'Setup',
      isNew: true,
    ),
  ];

  @override
  void dispose() {
    _bottomTabBarViewsController.dispose();
    _bottomTabBarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LFBottomTabBarScaffold(
      appBar: LFAppBar(
        title: LFAppBarTitle(text: widget.title),
        actions: [
          LFAppBarAction(
            icon: Icons.home,
            onPressed: () {},
          )
        ],
      ),
      bottomTabBarViewsController: _bottomTabBarViewsController,
      bottomTabBarController: _bottomTabBarController,
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
                  _bottomTabBarController.updateTabBadge(
                    tabIndex: i,
                    isNew: !tabItems[i].isNew,
                  );
                },
                child: Center(
                  child: Text('Button $e'),
                ),
              ),
            );
          }).toList(),
        ];
      },
      onPressed: (tabItems, index) {
        _bottomTabBarViewsController.updateTabSelectedWithTabItems(
          selectedIndex: index,
          tabItems: tabItems,
        );
        _bottomTabBarController.updateTabSelectedWithTabItems(
          selectedIndex: index,
          tabItems: tabItems,
        );
      },
    );
  }
}
