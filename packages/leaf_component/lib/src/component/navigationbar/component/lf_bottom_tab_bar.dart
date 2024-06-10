part of '../navigationbar.dart';

typedef LFBottomTabBarOnPressed = void Function(
  int index,
);

class LFBottomTabBar extends StatefulWidget {
  final LFBottomTabBarController controller;
  final LSBottomTextIconAnimationType type;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? elevation;
  final double notchMargin;
  final bool show;
  final LFBottomTabBarOnPressed? onPressed;

  const LFBottomTabBar({
    super.key,
    required this.controller,
    required this.type,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.shape,
    this.clipBehavior = Clip.none,
    this.padding,
    this.height,
    this.elevation,
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
    final backgroundColor = widget.backgroundColor ?? Colors.white;
    final borderRadius = widget.borderRadius;
    final boxShadow = widget.boxShadow;
    final elevation = widget.elevation;
    final notchMargin = widget.notchMargin;
    final show = widget.show;
    final padding = widget.padding;
    final height = widget.height;

    final items = _tabItems;
    final selectedIndex = _selectedIndex;

    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: boxShadow,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: BottomAppBar(
            elevation: elevation,
            clipBehavior: clipBehavior,
            notchMargin: notchMargin,
            padding: padding,
            height: height,
            color: backgroundColor,
            shape: shape,
            // shape: AutomaticNotchedShape(
            //   RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(25),
            //     ),
            //   ),
            // ),
            child: Container(
              child: _buildRow(
                context,
                items: items,
                selectedIndex: selectedIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required List<LFBottomTabItem> items,
    required int selectedIndex,
  }) {
    return Row(
      children: [
        ...items.asMap().entries.map((e) {
          final index = e.key;
          final item = e.value;

          final defaultIcon = item.defaultIcon;
          final activeIcon = item.activeIcon;
          final text = item.text;
          final defaultTextStyle = item.defaultTextStyle;
          final activeTextStyle = item.activeTextStyle;
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
                defaultIcon: defaultIcon,
                activeIcon: activeIcon,
                text: text,
                defaultTextStyle: defaultTextStyle,
                activeTextStyle: activeTextStyle,
                badgeCount: badgeCount,
                badgeAlignment: badgeAlignment,
              ),
            ),
          );
        })
      ],
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
  final Widget? defaultIcon;
  final Widget? activeIcon;
  final String? text;
  final TextStyle? defaultTextStyle;
  final TextStyle? activeTextStyle;
  final Widget? badgeWidget;
  final Alignment? badgeAlignment;
  final int badgeCount;

  const LSBottomTextIcon({
    super.key,
    required this.type,
    required this.selectedIndex,
    required this.index,
    required this.defaultIcon,
    this.activeIcon,
    this.text,
    this.defaultTextStyle,
    this.activeTextStyle,
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
    final defaultTextStyle = widget.defaultTextStyle;
    final activeTextStyle = widget.activeTextStyle;
    final defaultIcon = widget.defaultIcon;
    final activeIcon = widget.activeIcon;

    Alignment defaultBadgeAlignment =
        widget.badgeAlignment ?? const Alignment(1.0, -1.4);

    final bottomTextWidget = LFBottomText(
      text: widget.text,
      defaultTextStyle: defaultTextStyle,
      activeTextStyle: activeTextStyle,
      isActive: isActive,
    );
    final bottomIconWidget = LFBottomIcon(
      defaultWidget: defaultIcon,
      activeWidget: activeIcon,
      isActive: isActive,
    );

    late Widget bottomTextWrapWidget;
    if (type == LSBottomTextIconAnimationType.expand) {
      bottomTextWrapWidget = LFExpandAnimated(
        value: isActive,
        child: bottomTextWidget,
      );
    } else {
      bottomTextWrapWidget = bottomTextWidget;
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
                bottomIconWidget,
                bottomTextWrapWidget,
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
  final Widget? defaultWidget;
  final Widget? activeWidget;
  final bool isActive;

  const LFBottomIcon({
    super.key,
    required this.defaultWidget,
    required this.activeWidget,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final defaultWidget = this.defaultWidget;
    final activeWidget = this.activeWidget ?? defaultWidget;
    final isActive = this.isActive;

    if (isActive) {
      if (activeWidget is Icon) {
        final color = activeWidget.color ?? Colors.blueAccent;
        return Icon(activeWidget.icon, color: color);
      }
      return activeWidget ?? Container();
    } else {
      if (defaultWidget is Icon) {
        final color = defaultWidget.color ?? Colors.grey[600];
        return Icon(defaultWidget.icon, color: color);
      }
      return defaultWidget ?? Container();
    }
  }
}

class LFBottomText extends StatelessWidget {
  final String? text;
  final TextStyle? defaultTextStyle;
  final TextStyle? activeTextStyle;
  final bool isActive;

  const LFBottomText({
    super.key,
    required this.text,
    required this.defaultTextStyle,
    required this.activeTextStyle,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isNotEmpty(text),
      child: Text(
        text ?? '',
        style: isActive
            ? (activeTextStyle ??
                DefaultTextStyle.of(context).style.copyWith(
                      color: Colors.blueAccent,
                    ))
            : (defaultTextStyle ??
                DefaultTextStyle.of(context).style.copyWith(
                      color: Colors.grey[600],
                    )),
      ),
    );
  }
}
