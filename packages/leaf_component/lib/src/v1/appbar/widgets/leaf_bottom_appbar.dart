part of leaf_appbar_component;

class LeafBottomIndex {
  final int tabIndex;
  final int activeTabIndex;
  final bool scrollTop;

  LeafBottomIndex({
    required this.tabIndex,
    this.activeTabIndex = 0,
    this.scrollTop = false,
  });

  LeafBottomIndex copyWith({
    int? tabIndex,
    int? activeTabIndex,
    bool? scrollTop,
  }) {
    return LeafBottomIndex(
      tabIndex: tabIndex ?? this.tabIndex,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      scrollTop: scrollTop ?? this.scrollTop,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class LeafBottomAppBarItem extends Equatable {
  final LeafBottomIndex bottomIndex;
  final Widget? defaultWidget;
  final Widget? activeWidget;

  const LeafBottomAppBarItem({
    required this.bottomIndex,
    this.defaultWidget,
    this.activeWidget,
  });

  @override
  List<Object?> get props => [
        bottomIndex,
        defaultWidget,
        activeWidget,
      ];

  LeafBottomAppBarItem copyWith({required LeafBottomIndex bottomIndex}) {
    return LeafBottomAppBarItem(
      bottomIndex: bottomIndex,
      defaultWidget: defaultWidget,
      activeWidget: activeWidget,
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

typedef LeafBottomAppBarOnPress = void Function(
  List<LeafBottomIndex> bottomIndexItems,
  int index,
);

class LeafBottomAppBar extends StatelessWidget {
  final List<LeafBottomAppBarItem> items;
  final int selectedIndex;
  final Color? backgroundColor;
  final NotchedShape? shape;
  final Clip clipBehavior;
  final EdgeInsetsGeometry padding;
  final double notchMargin;
  final LeafBottomAppBarOnPress? onPress;

  const LeafBottomAppBar({
    Key? key,
    required this.items,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
    this.notchMargin = 4.0,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(0),
        topLeft: Radius.circular(0),
      ),
      child: BottomAppBar(
        elevation: 1.0,
        shape: shape,
        clipBehavior: clipBehavior,
        color: backgroundColor,
        notchMargin: notchMargin,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              ...items.asMap().entries.map((e) {
                final index = e.key;
                final item = e.value;

                final Widget? defaultWidget = item.defaultWidget;
                final Widget? activeWidget = item.activeWidget;

                void onTap() {
                  final scrollTop = selectedIndex == index;
                  final newItems = items.map((item) {
                    return item.copyWith(
                      bottomIndex: item.bottomIndex.copyWith(
                        activeTabIndex: index,
                        scrollTop: (index == item.bottomIndex.tabIndex)
                            ? scrollTop
                            : false,
                      ),
                    );
                  }).toList();
                  final bottomIndexs =
                      newItems.map((item) => item.bottomIndex).toList();
                  onPress?.call(bottomIndexs, index);
                }

                Widget? child =
                    (selectedIndex == index) ? activeWidget : defaultWidget;

                return Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: child,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
