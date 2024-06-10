import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'screens/feed_screen.dart';
import 'screens/home_screen.dart';
import 'screens/modal_screen.dart';
import 'screens/setup_screen.dart';

class BottomTabBarScreen extends ScreenStatefulWidget {
  final String title;

  const BottomTabBarScreen({
    super.key,
    required this.title,
  });

  @override
  State<BottomTabBarScreen> createState() => _BottomTabBarScreenState();
}

class _BottomTabBarScreenState extends ScreenState<BottomTabBarScreen> {
  @override
  bool get useSafeArea => false;

  @override
  Color? get backgroundColor => Colors.deepPurple;

  final LFBottomTabBarScaffoldController _bottomTabBarScaffoldController =
      LFBottomTabBarScaffoldController();

  StreamSubscription<int>? _subscription;

  final List<LFBottomTabItem> _tabItems = [
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 0),
      defaultIcon: const Icon(Icons.home, color: Colors.black),
      activeIcon: const Icon(Icons.home, color: Colors.red),
      text: 'Home',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 0,
      badgeAlignment: const Alignment(1.5, -1.5),
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 1),
      defaultIcon: const Icon(Icons.feed, color: Colors.black),
      activeIcon: const Icon(Icons.feed, color: Colors.red),
      text: 'Feed',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 0,
      badgeAlignment: const Alignment(1.5, -1.5),
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 2),
      defaultIcon: const Icon(Icons.settings, color: Colors.black),
      activeIcon: const Icon(Icons.settings, color: Colors.red),
      text: 'Setup',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 1,
      badgeAlignment: const Alignment(1.5, -1.5),
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
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
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
      backgroundColor: Colors.brown,
      // height: 56.0,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x19101828),
          offset: Offset(0, -4),
          blurRadius: 8,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: Color(0x0f101828),
          offset: Offset(0, -2),
          blurRadius: 4,
          spreadRadius: -2,
        ),
      ],
      tabItems: _tabItems,
      selectedIndex: 1,
      autoSelected: false,
      // radius: const BorderRadius.only(
      //   topLeft: Radius.circular(16.0),
      //   topRight: Radius.circular(16.0),
      // ),
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
