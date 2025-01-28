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
      defaultIcon: const LFIcons(
        Icons.home,
        color: Colors.grey,
        width: 40.0,
      ),
      activeIcon: const LFIcons(
        Icons.home,
        color: Colors.red,
        width: 40.0,
      ),
      text: 'Home',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 0,
      badgeAlignment: const Alignment(1.5, -1.5),
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 1),
      defaultIcon: const LFIcons(
        Icons.feed,
        color: Colors.grey,
        width: 24.0,
      ),
      activeIcon: const LFIcons(
        Icons.feed,
        color: Colors.red,
        width: 24.0,
      ),
      text: 'Feed',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 0,
      badgeAlignment: const Alignment(1.5, -1.5),
    ),
    LFBottomTabItem(
      bottomTabIndex: LFBottomTabIndex(tabIndex: 2),
      defaultIcon: const LFIcons(
        Icons.settings,
        color: Colors.grey,
        width: 24.0,
      ),
      activeIcon: const LFIcons(
        Icons.settings,
        color: Colors.red,
        width: 24.0,
      ),
      text: 'Setup',
      defaultTextStyle: const TextStyle(fontSize: 10.0, color: Colors.black),
      activeTextStyle: const TextStyle(fontSize: 10.0, color: Colors.red),
      badgeCount: 1,
      badgeAlignment: const Alignment(1.5, -1.5),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _subscription =
        _bottomTabBarScaffoldController.addSubscription((index) async {
      debugPrint('bottomTabBar subscription: $index');
    });
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
    const icon = LFIcons(
      Icons.home,
      color: Colors.grey,
      width: 30.0,
    );
    final newIcon = LFIcons.buildUpdateColor(
      icon,
      color: Colors.red,
    );

    return LFBottomTabBarScaffold(
      appBar: LFAppBar(
        title: LFAppBarTitle(text: widget.title),
        actions: [
          LFAppBarAction(
            icon: newIcon,
            onPressed: () {
              debugPrint('onPressed!!');
            },
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
      // deactivateIndexes: [2],
      // radius: const BorderRadius.only(
      //   topLeft: Radius.circular(16.0),
      //   topRight: Radius.circular(16.0),
      // ),
      children: (tabItems) {
        return [
          HomeScreen(
            index: tabItems[0].bottomTabIndex,
            bottomTabBarScaffoldController: _bottomTabBarScaffoldController,
          ),
          FeedScreen(
            index: tabItems[1].bottomTabIndex,
            bottomTabBarScaffoldController: _bottomTabBarScaffoldController,
          ),
          SetupScreen(
            index: tabItems[2].bottomTabIndex,
            bottomTabBarScaffoldController: _bottomTabBarScaffoldController,
          )
        ];
      },
      onSelected: (selectedIndex, previousIndex, isActive) async {
        debugPrint('onSelected: $selectedIndex, $previousIndex, $isActive');

        if (selectedIndex == 0) {
          await LFNavigation.pushNamed(
            context,
            '/ModalScreen',
            child: const ModalScreen(),
          );
          // if (previousIndex != null) {
          //   _bottomTabBarScaffoldController.selectedIndex = previousIndex;
          // }
          return false;
        }

        return true;
      },
    );
  }
}
