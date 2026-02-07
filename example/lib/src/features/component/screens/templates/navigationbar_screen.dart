import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_action_tile.dart';

class NavigationBarScreen extends LFScreenStatefulWidgetV2 {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends LFScreenStateV2<NavigationBarScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Navigation Bar'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Bottom Tab Bar',
          children: [
            ShowcaseActionTile(
              label: 'Full scaffold with tabs',
              buttonText: 'Open Tab Demo',
              description: 'Opens a new screen with bottom navigation',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _TabDemoScreen()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _TabDemoScreen extends StatefulWidget {
  const _TabDemoScreen();

  @override
  State<_TabDemoScreen> createState() => _TabDemoScreenState();
}

class _TabDemoScreenState extends State<_TabDemoScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Center(child: Text('Home')),
      const Center(child: Text('Search')),
      const Center(child: Text('Profile')),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Tab Demo')),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
