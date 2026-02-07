import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class TabsScreen extends LeafScreenStatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends LeafScreenState<TabsScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Tabs'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;

    return Column(
      children: [
        LeafTabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
        Expanded(
          child: LeafTabView(
            controller: _tabController,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(spacing.xl),
                  child: Text('Content for Tab 1', style: typography.bodyLarge),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(spacing.xl),
                  child: Text('Content for Tab 2', style: typography.bodyLarge),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(spacing.xl),
                  child: Text('Content for Tab 3', style: typography.bodyLarge),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
