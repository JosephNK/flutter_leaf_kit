import 'package:example/src/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import 'pages/page_screen_01.dart';
import 'pages/page_screen_02.dart';
import 'pages/page_screen_03.dart';
import 'pages/page_screen_04.dart';

class MainScreen extends ControllerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ControllerState<MainScreen> {
  int _selectedIndex = 0;

  List<LeafBottomIndex> _indexs = [
    LeafBottomIndex(tabIndex: 0),
    LeafBottomIndex(tabIndex: 1),
    LeafBottomIndex(tabIndex: 2),
    LeafBottomIndex(tabIndex: 3),
  ];

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
    return Stack(
      children: [
        IndexedStack(
          index: _selectedIndex,
          children: [
            PageScreen01(
              bottomIndex: _indexs[0],
            ),
            PageScreen02(
              bottomIndex: _indexs[1],
            ),
            PageScreen03(
              bottomIndex: _indexs[2],
            ),
            PageScreen04(
              bottomIndex: _indexs[3],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context, Object? state) {
    return LeafBottomAppBar(
      items: [
        LeafBottomAppBarItem(
          bottomIndex: _indexs[0],
          defaultWidget: const Icon(AppIcons.home, color: AppColors.disabled),
          activeWidget: const Icon(AppIcons.home, color: AppColors.primary),
        ),
        LeafBottomAppBarItem(
          bottomIndex: _indexs[1],
          defaultWidget: const Icon(AppIcons.map, color: AppColors.disabled),
          activeWidget: const Icon(AppIcons.map, color: AppColors.primary),
        ),
        LeafBottomAppBarItem(
          bottomIndex: _indexs[2],
          defaultWidget: const Icon(AppIcons.stats, color: AppColors.disabled),
          activeWidget: const Icon(AppIcons.stats, color: AppColors.primary),
        ),
        LeafBottomAppBarItem(
          bottomIndex: _indexs[3],
          defaultWidget: const Icon(AppIcons.menu, color: AppColors.disabled),
          activeWidget: const Icon(AppIcons.menu, color: AppColors.primary),
        ),
      ],
      backgroundColor: AppColors.surface1,
      selectedIndex: _selectedIndex,
      onPress: (bottomIndexItems, index) {
        setState(() {
          _indexs = bottomIndexItems;
          _selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, Object? state) {
    return null;
  }

  @override
  void bottomAppBarTapedWhenVisible() {
    // TODO: implement bottomAppBarTapedWhenVisible
  }
}
