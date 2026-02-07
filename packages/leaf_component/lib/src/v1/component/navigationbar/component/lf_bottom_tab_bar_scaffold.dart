part of '../navigationbar.dart';

@Deprecated('Use LFBottomTabBarScaffoldV2 instead')
class LFBottomTabBarScaffold extends StatefulWidget {
  final LFBottomTabBarScaffoldController scaffoldController;
  final List<LFBottomTabItem> tabItems;
  final int selectedIndex;
  final List<int> deactivateIndexes;
  final LFBottomTabBarViewsChildren children;
  final LSBottomTextIconAnimationType animationType;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? elevation;
  final double notchMargin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool isShowTabBar;
  final LFBottomTabBarOnSelected? onSelected;

  const LFBottomTabBarScaffold({
    super.key,
    required this.scaffoldController,
    required this.tabItems,
    required this.selectedIndex,
    required this.children,
    this.animationType = LSBottomTextIconAnimationType.none,
    this.deactivateIndexes = const [],
    this.appBar,
    this.padding,
    this.height,
    this.elevation,
    this.notchMargin = 4.0,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.isShowTabBar = true,
    this.onSelected,
  });

  @override
  State<LFBottomTabBarScaffold> createState() => _LFBottomTabBarScaffoldState();
}

class _LFBottomTabBarScaffoldState extends State<LFBottomTabBarScaffold> {
  @override
  void initState() {
    super.initState();

    final tabItems = widget.tabItems;
    final selectedIndex = widget.selectedIndex;
    final scaffoldController = widget.scaffoldController;
    final tabBarViewsController = scaffoldController.tabBarViewsController;
    final tabBarController = scaffoldController.tabBarController;

    final rebuildTabItems = tabItems.map((tabItem) {
      return tabItem.copyWith(
        bottomTabIndex: tabItem.bottomTabIndex.copyWith(
          activeTabIndex: () => selectedIndex,
        ),
      );
    }).toList();

    // Set ScaffoldController SelectedIndex
    scaffoldController.selectedIndex = selectedIndex;

    // Set TabBarViewsController SelectedIndex and TabItems
    tabBarViewsController.selectedIndex = selectedIndex;
    tabBarViewsController.tabItems = rebuildTabItems;

    // Set TabBarController SelectedIndex and TabItems
    tabBarController.selectedIndex = selectedIndex;
    tabBarController.tabItems = tabItems;
  }

  @override
  Widget build(BuildContext context) {
    final appbar = widget.appBar;
    final children = widget.children;
    final scaffoldController = widget.scaffoldController;
    final tabBarViewsController = scaffoldController.tabBarViewsController;
    final tabBarController = scaffoldController.tabBarController;
    final animationType = widget.animationType;
    final padding = widget.padding;
    final height = widget.height;
    final elevation = widget.elevation;
    final notchMargin = widget.notchMargin;
    final backgroundColor = widget.backgroundColor;
    final borderRadius = widget.borderRadius;
    final boxShadow = widget.boxShadow;
    final isShowTabBar = widget.isShowTabBar;
    final deactivateIndexes = widget.deactivateIndexes;
    final onSelected = widget.onSelected;

    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.transparent,
      body: LFBottomTabBarViews(
        controller: tabBarViewsController,
        children: children,
      ),
      bottomNavigationBar: LFBottomTabBar(
        scaffoldController: scaffoldController,
        controller: tabBarController,
        type: animationType,
        padding: padding,
        height: height,
        elevation: elevation,
        notchMargin: notchMargin,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        show: isShowTabBar,
        onPressed: (selectedIndex, isActive) {
          // bool isSameIndex = (tabBarController.selectedIndex == selectedIndex);
          // if (!isSameIndex && selectedIndex != deactivateIndex) {
          //   if (autoSelected) {
          //     scaffoldController.selectedIndex = selectedIndex;
          //   }
          // }
          if (deactivateIndexes.contains(selectedIndex)) {
            return;
          }
          scaffoldController.selectedIndex = selectedIndex;
        },
        onSelected: (selectedIndex, previousIndex, isActive) async {
          if (deactivateIndexes.contains(selectedIndex)) {
            return false;
          }
          if (onSelected == null) {
            return true;
          }
          return onSelected.call(selectedIndex, previousIndex, isActive);
        },
      ),
    );
  }
}
