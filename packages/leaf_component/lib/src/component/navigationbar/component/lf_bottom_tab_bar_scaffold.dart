part of lf_navigationbar;

class LFBottomTabBarScaffold extends StatefulWidget {
  final LFBottomTabBarViewsController bottomTabBarViewsController;
  final LFBottomTabBarController bottomTabBarController;
  final List<LFBottomTabItem> tabItems;
  final int selectedIndex;
  final LFBottomTabBarViewsChildren children;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry padding;
  final Color activeColor;
  final Color inactiveColor;
  final bool isShowTabBar;
  final LFBottomTabBarOnPressed? onPressed;

  const LFBottomTabBarScaffold({
    Key? key,
    required this.bottomTabBarViewsController,
    required this.bottomTabBarController,
    required this.tabItems,
    required this.selectedIndex,
    required this.children,
    this.appBar,
    this.padding = const EdgeInsets.all(0.0),
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
    final bottomTabBarViewsController = widget.bottomTabBarViewsController;
    final bottomTabBarController = widget.bottomTabBarController;

    final rebuildTabItems = tabItems.map((tabItem) {
      return tabItem.copyWith(
        bottomTabIndex: tabItem.bottomTabIndex.copyWith(
          activeTabIndex: selectedIndex,
        ),
      );
    }).toList();

    bottomTabBarViewsController.selectedIndex = selectedIndex;
    bottomTabBarViewsController.tabItems = rebuildTabItems;

    bottomTabBarController.selectedIndex = selectedIndex;
    bottomTabBarController.tabItems = tabItems;
  }

  @override
  Widget build(BuildContext context) {
    final appbar = widget.appBar;
    final children = widget.children;
    final bottomTabBarViewsController = widget.bottomTabBarViewsController;
    final bottomTabBarController = widget.bottomTabBarController;
    final padding = widget.padding;
    final activeColor = widget.activeColor;
    final inactiveColor = widget.inactiveColor;
    final isShowTabBar = widget.isShowTabBar;
    final onPressed = widget.onPressed;

    return Scaffold(
      appBar: appbar,
      body: LFBottomTabBarViews(
        controller: bottomTabBarViewsController,
        children: children,
      ),
      bottomNavigationBar: LFBottomTabBar(
        controller: bottomTabBarController,
        padding: padding,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        show: isShowTabBar,
        onPressed: onPressed,
      ),
    );
  }
}
