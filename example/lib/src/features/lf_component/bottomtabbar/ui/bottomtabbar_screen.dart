import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'screens/feed_screen.dart';
import 'screens/home_screen.dart';
import 'screens/modal_screen.dart';
import 'screens/setup_screen.dart';

class BottomTabBarScreen extends StatefulWidget {
  final String title;

  const BottomTabBarScreen({
    super.key,
    required this.title,
  });

  @override
  State<BottomTabBarScreen> createState() => _BottomTabBarScreenState();
}

class _BottomTabBarScreenState extends State<BottomTabBarScreen> {
  final LFBottomTabBarScaffoldController _bottomTabBarScaffoldController =
      LFBottomTabBarScaffoldController();

  StreamSubscription<int>? _subscription;

  final List<LFBottomTabItem> _tabItems = [
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 0),
      defaultIcon: const Icon(Icons.home),
      text: 'Home',
      badgeCount: 0,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 1),
      defaultIcon: const Icon(Icons.feed),
      text: 'Feed',
      badgeCount: 0,
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 2),
      defaultIcon: const Icon(Icons.settings),
      text: 'Setup',
      badgeCount: 1,
    ),
  ];

  @override
  void initState() {
    _subscription = _bottomTabBarScaffoldController.addSubscription((value) {
      debugPrint('bottomTabBar subscription: $value');
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
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
      animationType: LSBottomTextIconAnimationType.bounce,
      tabItems: _tabItems,
      selectedIndex: 1,
      autoSelected: false,
      children: (tabItems) {
        return [
          HomeScreen(
            index: tabItems[0].bottomTabIndex,
          ),
          FeedScreen(
            index: tabItems[1].bottomTabIndex,
          ),
          SetupScreen(
            index: tabItems[2].bottomTabIndex,
            onScreenTap: () {
              _bottomTabBarScaffoldController.updateTabBadge(
                tabIndex: 2,
                badgeCount: 9,
              );
            },
          )
        ];
      },
      onPressed: (index) {
        if (index == 0) {
          LFNavigation.pushNamed(
            context,
            '/ModalScreen',
            child: const ModalScreen(),
          );
          return;
        }
        _bottomTabBarScaffoldController.selectedIndex = index;
      },
    );
  }
}
