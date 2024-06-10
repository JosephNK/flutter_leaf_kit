part of '../navigationbar.dart';

class LFBottomTabBarScaffold extends StatefulWidget {
  final LFBottomTabBarScaffoldController scaffoldController;
  final List<LFBottomTabItem> tabItems;
  final int selectedIndex;
  final int deactivateIndex;
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
  final bool autoSelected;
  final ValueChanged<int>? onPressed;

  const LFBottomTabBarScaffold({
    super.key,
    required this.scaffoldController,
    required this.tabItems,
    required this.selectedIndex,
    required this.children,
    this.animationType = LSBottomTextIconAnimationType.none,
    this.deactivateIndex = -1,
    this.appBar,
    this.padding,
    this.height,
    this.elevation,
    this.notchMargin = 4.0,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.isShowTabBar = true,
    this.autoSelected = true,
    this.onPressed,
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

    scaffoldController.selectedIndex = selectedIndex;
    tabBarViewsController.tabItems = rebuildTabItems;
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
    final autoSelected = widget.autoSelected;
    final deactivateIndex = widget.deactivateIndex;
    final onPressed = widget.onPressed;

    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.transparent,
      body: LFBottomTabBarViews(
        controller: tabBarViewsController,
        children: children,
      ),
      bottomNavigationBar: LFBottomTabBar(
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
        onPressed: (index) {
          bool isSameIndex = (tabBarController.selectedIndex == index);
          if (!isSameIndex && index != deactivateIndex) {
            if (autoSelected) {
              scaffoldController.selectedIndex = index;
            }
            onPressed?.call(index);
          }
        },
      ),
    );
  }
}
