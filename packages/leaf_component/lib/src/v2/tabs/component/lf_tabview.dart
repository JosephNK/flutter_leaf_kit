part of lf_tabs;

class LFTabView extends StatelessWidget {
  final TabController? controller;
  final List<Widget> children;

  const LFTabView({
    Key? key,
    required this.controller,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: children,
    );
  }
}
