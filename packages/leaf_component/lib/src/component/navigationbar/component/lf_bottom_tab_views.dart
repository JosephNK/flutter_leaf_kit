part of '../lf_navigationbar.dart';

typedef LFBottomTabBarViewsChildren = List<Widget> Function(
  List<LFBottomTabItem> tabItems,
);

class LFBottomTabBarViews extends StatefulWidget {
  final LFBottomTabBarViewsController controller;
  final LFBottomTabBarViewsChildren children;

  const LFBottomTabBarViews({
    super.key,
    required this.controller,
    required this.children,
  });

  @override
  State<LFBottomTabBarViews> createState() => _LFBottomTabBarViewsState();
}

class _LFBottomTabBarViewsState extends State<LFBottomTabBarViews> {
  StreamSubscription<LFBottomTabBarViewsEvent>? _streamSubscription;

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
      if (event is LFBottomTabBarViewsSelectedEvent) {
        final selectedIndex = event.selectedIndex;

        setState(() {
          _selectedIndex = selectedIndex;
        });
      }

      if (event is LFBottomTabBarViewsItemsEvent) {
        final tabItems = event.tabItems;

        setState(() {
          _tabItems = tabItems;
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
    final children = widget.children;
    final tabItems = _tabItems;

    return IndexedStack(
      index: _selectedIndex,
      children: [
        ...children.call(tabItems),
      ],
    );
  }
}
