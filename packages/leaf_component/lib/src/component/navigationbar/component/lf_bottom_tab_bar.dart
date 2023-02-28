part of lf_navigationbar;

typedef LFBottomTabBarOnPressed = void Function(
  List<LFBottomTabItem> items,
  int index,
);

class LFBottomTabBar extends StatefulWidget {
  final LFBottomTabBarController controller;
  final Color? backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry padding;
  final double notchMargin;
  final bool show;
  final LFBottomTabBarOnPressed? onPressed;

  const LFBottomTabBar({
    Key? key,
    required this.controller,
    this.backgroundColor,
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.grey,
    this.shape,
    this.clipBehavior = Clip.none,
    this.padding = const EdgeInsets.all(0.0),
    this.notchMargin = 4.0,
    this.show = true,
    this.onPressed,
  }) : super(key: key);

  @override
  State<LFBottomTabBar> createState() => _LFBottomTabBarState();
}

class _LFBottomTabBarState extends State<LFBottomTabBar> {
  StreamSubscription<LFBottomTabBarEvent>? _streamSubscription;

  late int _selectedIndex;
  late List<LFBottomTabItem> _tabItems;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.controller.selectedIndex;
    _tabItems = widget.controller.tabItems;

    _streamSubscription = widget.controller.streamController?.stream
        .asBroadcastStream()
        .listen((event) {
      if (event is LFBottomTabBarSelectedEvent) {
        final selectedIndex = event.selectedIndex;

        setState(() {
          _selectedIndex = selectedIndex;
        });
      }

      if (event is LFBottomTabBarItemsEvent) {
        final tabItems = event.tabItems;

        setState(() {
          _tabItems = tabItems;
        });
      }

      if (event is LFBottomTabBarBadgeEvent) {
        final tabIndex = event.tabIndex;
        final isNew = event.isNew;

        final newItems = _tabItems.map((item) {
          if (item.bottomTabIndex.tabIndex == tabIndex) {
            return item.copyWith(
              isNew: isNew,
            );
          }
          return item;
        }).toList();

        setState(() {
          _tabItems = newItems;
        });
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shape = widget.shape;
    final clipBehavior = widget.clipBehavior;
    final backgroundColor = widget.backgroundColor;
    final activeColor = widget.activeColor;
    final inactiveColor = widget.inactiveColor;
    final notchMargin = widget.notchMargin;
    final show = widget.show;
    final padding = widget.padding;

    final items = _tabItems;
    final selectedIndex = _selectedIndex;

    return Visibility(
      visible: show,
      child: BottomAppBar(
        elevation: 1.0,
        shape: shape,
        clipBehavior: clipBehavior,
        color: backgroundColor ?? Colors.white,
        notchMargin: notchMargin,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              ...items.asMap().entries.map((e) {
                final index = e.key;
                final item = e.value;

                final defaultIcon = item.defaultIcon;
                final activeIcon = item.activeIcon;
                final text = item.text;
                final isNew = item.isNew;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final didSelected = (selectedIndex == index);
                      final newItems = items.map((item) {
                        return item.copyWith(
                            bottomTabIndex: item.bottomTabIndex.copyWith(
                          activeTabIndex: index,
                          didSelected: (index == item.bottomTabIndex.tabIndex)
                              ? didSelected
                              : false,
                        ));
                      }).toList();
                      widget.onPressed?.call(newItems, index);
                    },
                    child: LSBottomTextIcon(
                      selectedIndex: selectedIndex,
                      index: index,
                      activeColor: activeColor,
                      inactiveColor: inactiveColor,
                      defaultIcon: defaultIcon,
                      activeIcon: activeIcon,
                      text: text,
                      isNew: isNew,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class LSBottomTextIcon extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final Color activeColor;
  final Color inactiveColor;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final bool isNew;

  const LSBottomTextIcon({
    Key? key,
    required this.selectedIndex,
    required this.index,
    required this.activeColor,
    required this.inactiveColor,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.isNew = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = (selectedIndex == index);
    final activeColor = this.activeColor;
    final inactiveColor = this.inactiveColor;
    final defaultIcon = this.defaultIcon;
    final activeIcon = this.activeIcon;
    final color = isActive ? activeColor : inactiveColor;

    final icon = (activeIcon != null && isActive) ? activeIcon : defaultIcon;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LFBottomIcon(
                    widget: icon,
                    color: color,
                  ),
                  LFBottomText(
                    text: text,
                    color: color,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Visibility(
                visible: isNew,
                child: const Align(
                  alignment: Alignment(0.7, -0.95),
                  child: LFNewBadge(),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class LFBottomIcon extends StatelessWidget {
  final Widget? widget;
  final Color? color;

  const LFBottomIcon({
    Key? key,
    required this.widget,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = this.widget;
    if (widget == null) {
      return Container();
    }
    if (widget is Icon) {
      return Icon(widget.icon, color: color);
    }
    return widget;
  }
}

class LFBottomText extends StatelessWidget {
  final String? text;
  final Color? color;

  const LFBottomText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isNotEmpty(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          text ?? '',
          style: DefaultTextStyle.of(context).style.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}
