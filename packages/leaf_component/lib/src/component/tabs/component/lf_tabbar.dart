part of '../tabs.dart';

class LFTabBar extends StatelessWidget {
  final TabController? controller;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? indicatorColor;
  final EdgeInsets? indicatorPadding;
  final List<Tab> tabs;

  const LFTabBar({
    super.key,
    required this.controller,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorColor,
    this.indicatorPadding,
    this.tabs = const [],
  });

  @override
  Widget build(BuildContext context) {
    final labelColor = this.labelColor ?? Colors.blueAccent;
    final unselectedLabelColor = this.unselectedLabelColor ?? Colors.black54;
    final indicatorColor = this.indicatorColor ?? Colors.blueAccent;

    return TabBar(
      controller: controller,
      indicatorPadding: indicatorPadding ??
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicatorColor: indicatorColor,
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
      tabs: tabs,
    );
  }
}
