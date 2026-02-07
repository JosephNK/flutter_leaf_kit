import 'package:flutter/material.dart';

@immutable
class LeafTabView extends StatelessWidget {
  final TabController? controller;
  final List<Widget> children;
  final ScrollPhysics? physics;

  const LeafTabView({
    super.key,
    this.controller,
    required this.children,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      physics: physics,
      children: children,
    );
  }
}
