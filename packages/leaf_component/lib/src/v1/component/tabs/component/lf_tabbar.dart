part of '../tabs.dart';

@Deprecated('Use LeafTabBar instead')
class LFTabBar extends StatelessWidget {
  final TabController? controller;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? indicatorColor;
  final Color? dividerColor;
  final bool isScrollable;
  final WidgetStateProperty<Color?>? overlayColor;
  final EdgeInsets? indicatorPadding;
  final EdgeInsets? labelPadding;
  final List<Tab> tabs;

  const LFTabBar({
    super.key,
    required this.controller,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorColor,
    this.dividerColor,
    this.isScrollable = false,
    this.overlayColor,
    this.indicatorPadding,
    this.labelPadding,
    this.tabs = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: labelColor ?? Colors.blueAccent,
      unselectedLabelColor: unselectedLabelColor ?? Colors.black54,
      indicatorColor: indicatorColor ?? Colors.blueAccent,
      dividerColor: dividerColor,
      labelStyle: labelStyle ??
          const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
      unselectedLabelStyle: unselectedLabelStyle ??
          const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
      indicatorPadding: indicatorPadding ??
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      labelPadding: labelPadding,
      isScrollable: isScrollable,
      overlayColor: overlayColor,
      tabs: tabs,
    );
  }
}
