import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

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
      tabItems: _tabItems,
      selectedIndex: 1,
      autoSelected: false,
      children: (tabItems) {
        return [
          SubScreen0(
            index: tabItems[0].bottomTabIndex,
          ),
          SubScreen1(
            index: tabItems[1].bottomTabIndex,
          ),
          SubScreen2(
            index: tabItems[2].bottomTabIndex,
            onTap: () {
              _bottomTabBarScaffoldController.updateTabBadge(
                tabIndex: 2,
                isNew: !tabItems[2].isNew,
              );
            },
          )
        ];
      },
      onPressed: (index) {
        _bottomTabBarScaffoldController.selectedIndex = index;
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class SubScreen0 extends ScreenStatefulWidget {
  final VoidCallback? onTap;

  const SubScreen0({
    super.key,
    super.index,
    this.onTap,
  });

  @override
  State<SubScreen0> createState() => _SubScreen0State();
}

class _SubScreen0State extends ScreenState<SubScreen0> {
  @override
  Color? get backgroundColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('SubScreen0 buildScreen called');
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return GestureDetector(
      onTap: widget.onTap,
      child: const Center(
        child: Text('SubScreen0'),
      ),
    );
  }
}

class SubScreen1 extends ScreenStatefulWidget {
  final VoidCallback? onTap;

  const SubScreen1({
    super.key,
    super.index,
    this.onTap,
  });

  @override
  State<SubScreen1> createState() => _SubScreen1State();
}

class _SubScreen1State extends ScreenState<SubScreen1> {
  @override
  Color? get backgroundColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('SubScreen1 buildScreen called');
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return GestureDetector(
      onTap: widget.onTap,
      child: const Center(
        child: Text('SubScreen1'),
      ),
    );
  }
}

class SubScreen2 extends ScreenStatefulWidget {
  final VoidCallback? onTap;

  const SubScreen2({
    super.key,
    super.index,
    this.onTap,
  });

  @override
  State<SubScreen2> createState() => _SubScreen2State();
}

class _SubScreen2State extends ScreenState<SubScreen2> {
  @override
  Color? get backgroundColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  SafeAreaInsets get safeAreaInsets =>
      SafeAreaInsets.fromLTRB(true, false, true, true);

  @override
  Widget? buildScreen(BuildContext context) {
    Logging.i('SubScreen2 buildScreen called');
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return null;
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return GestureDetector(
      onTap: widget.onTap,
      child: const Center(
        child: Text('SubScreen2'),
      ),
    );
  }
}
