part of '../navigationbar.dart';

typedef LFBottomTabBarOnPressed = void Function(
  int index,
);

class LFBottomTabBar extends StatefulWidget {
  final LFBottomTabBarController controller;
  final LSBottomTextIconAnimationType type;
  final Color? backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double notchMargin;
  final bool show;
  final LFBottomTabBarOnPressed? onPressed;

  const LFBottomTabBar({
    super.key,
    required this.controller,
    required this.type,
    this.backgroundColor,
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = Colors.grey,
    this.shape,
    this.clipBehavior = Clip.none,
    this.padding,
    this.height,
    this.notchMargin = 4.0,
    this.show = true,
    this.onPressed,
  });

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
        final badgeCount = event.badgeCount;

        final newItems = _tabItems.map((item) {
          if (item.bottomTabIndex.tabIndex == tabIndex) {
            return item.copyWith(
              badgeCount: badgeCount,
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
    final height = widget.height;

    final items = _tabItems;
    final selectedIndex = _selectedIndex;

    EdgeInsetsGeometry? defaultPadding = padding;
    final useMaterial3 = Theme.of(context).useMaterial3;
    if (!useMaterial3) {
      defaultPadding =
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
    }

    return Visibility(
      visible: show,
      child: BottomAppBar(
        elevation: 1.0,
        shape: shape,
        clipBehavior: clipBehavior,
        color: backgroundColor ?? Colors.white,
        notchMargin: notchMargin,
        padding: defaultPadding,
        height: height,
        child: Row(
          children: [
            ...items.asMap().entries.map((e) {
              final index = e.key;
              final item = e.value;

              final defaultIcon = item.defaultIcon;
              final activeIcon = item.activeIcon;
              final text = item.text;
              final badgeCount = item.badgeCount;
              final badgeAlignment = item.badgeAlignment;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    widget.onPressed?.call(index);
                  },
                  child: LSBottomTextIcon(
                    type: widget.type,
                    selectedIndex: selectedIndex,
                    index: index,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                    defaultIcon: defaultIcon,
                    activeIcon: activeIcon,
                    text: text,
                    badgeCount: badgeCount,
                    badgeAlignment: badgeAlignment,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

enum LSBottomTextIconAnimationType {
  none,
  expand,
  bounce,
}

class LSBottomTextIcon extends StatefulWidget {
  final LSBottomTextIconAnimationType type;
  final int selectedIndex;
  final int index;
  final Color activeColor;
  final Color inactiveColor;
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final Widget? badgeWidget;
  final Alignment? badgeAlignment;
  final int badgeCount;

  const LSBottomTextIcon({
    super.key,
    required this.type,
    required this.selectedIndex,
    required this.index,
    required this.activeColor,
    required this.inactiveColor,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.badgeWidget,
    this.badgeAlignment,
    this.badgeCount = 0,
  });

  @override
  State<LSBottomTextIcon> createState() => _LSBottomTextIconState();
}

class _LSBottomTextIconState extends State<LSBottomTextIcon> {
  final bool _bouncingLoaded = false;

  @override
  Widget build(BuildContext context) {
    final isActive = (widget.selectedIndex == widget.index);
    final type = widget.type;
    final activeColor = widget.activeColor;
    final inactiveColor = widget.inactiveColor;
    final defaultIcon = widget.defaultIcon;
    final activeIcon = widget.activeIcon;
    final color = isActive ? activeColor : inactiveColor;

    final icon = (activeIcon != null && isActive) ? activeIcon : defaultIcon;

    Alignment defaultBadgeAlignment =
        widget.badgeAlignment ?? const Alignment(1.0, -1.4);

    late Widget bottomTextWidget;
    if (type == LSBottomTextIconAnimationType.expand) {
      bottomTextWidget = LFExpandAnimated(
        value: isActive,
        child: LFBottomText(text: widget.text, color: color),
      );
    } else {
      bottomTextWidget = LFBottomText(text: widget.text, color: color);
    }

    Widget iconTextWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LFBottomIcon(
                  widget: icon,
                  color: color,
                ),
                bottomTextWidget,
              ],
            ),
            Positioned.fill(
              child: Visibility(
                visible: widget.badgeCount != 0,
                child: Align(
                  alignment: defaultBadgeAlignment,
                  child: widget.badgeWidget ??
                      LFBadge(
                        text: widget.badgeCount.toString(),
                        textStyle: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                ),
              ),
            ),
          ],
        )
      ],
    );

    late Widget child;
    if (type == LSBottomTextIconAnimationType.bounce) {
      child = LFBouncingAnimated(
        value: isActive,
        curve: Curves.bounceInOut,
        enableInitAnimation: isActive,
        onAnimationStatus: (status) {
          if (_bouncingLoaded) return;
        },
        child: iconTextWidget,
      );
    } else {
      child = iconTextWidget;
    }

    return Container(
      constraints: const BoxConstraints(minHeight: kBottomNavigationBarHeight),
      child: child,
    );
  }
}

class LFBottomIcon extends StatelessWidget {
  final Widget? widget;
  final Color? color;

  const LFBottomIcon({
    super.key,
    required this.widget,
    required this.color,
  });

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
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isNotEmpty(text),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
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
