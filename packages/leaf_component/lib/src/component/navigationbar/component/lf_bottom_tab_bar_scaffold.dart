part of lf_navigationbar;

class LFBottomTabBarScaffold extends StatefulWidget {
  final LFBottomTabBarScaffoldController scaffoldController;
  final List<LFBottomTabItem> tabItems;
  final int selectedIndex;
  final int deactivateIndex;
  final LFBottomTabBarViewsChildren children;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final bool isShowTabBar;
  final ValueChanged<int>? onPressed;

  const LFBottomTabBarScaffold({
    Key? key,
    required this.scaffoldController,
    required this.tabItems,
    required this.selectedIndex,
    required this.children,
    this.deactivateIndex = -1,
    this.appBar,
    this.padding = const EdgeInsets.all(0.0),
    this.backgroundColor,
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.grey,
    this.isShowTabBar = true,
    this.onPressed,
  }) : super(key: key);

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
    final padding = widget.padding;
    final backgroundColor = widget.backgroundColor;
    final activeColor = widget.activeColor;
    final inactiveColor = widget.inactiveColor;
    final isShowTabBar = widget.isShowTabBar;
    final deactivateIndex = widget.deactivateIndex;
    final onPressed = widget.onPressed;

    return Scaffold(
      appBar: appbar,
      body: LFBottomTabBarViews(
        controller: tabBarViewsController,
        children: children,
      ),
      bottomNavigationBar: LFBottomTabBar(
        controller: tabBarController,
        padding: padding,
        backgroundColor: backgroundColor,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        show: isShowTabBar,
        onPressed: (index) {
          bool isSameIndex = (tabBarController.selectedIndex == index);
          if (index != deactivateIndex) {
            tabBarViewsController.selectedIndex = index;
            tabBarController.selectedIndex = index;
          }
          if (!isSameIndex) {
            onPressed?.call(index);
          }
        },
      ),
    );
  }
}
