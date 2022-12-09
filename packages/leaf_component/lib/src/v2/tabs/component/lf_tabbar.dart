part of lf_tabs;

class LFTabBar extends StatelessWidget {
  final TabController? controller;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final List<Tab> tabs;

  const LFTabBar({
    Key? key,
    required this.controller,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.tabs = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelColor = this.labelColor ?? Colors.blueAccent;
    final unselectedLabelColor = this.unselectedLabelColor ?? Colors.black54;
    final indicatorColor = this.indicatorColor ?? Colors.blueAccent;

    return TabBar(
      controller: controller,
      indicatorPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicatorColor: indicatorColor,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      ),
      tabs: tabs,
    );
  }
}
