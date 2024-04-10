part of '../lf_tabs.dart';

class LFTabView extends StatelessWidget {
  final TabController? controller;
  final List<Widget> children;

  const LFTabView({
    super.key,
    required this.controller,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: children,
    );
  }
}
