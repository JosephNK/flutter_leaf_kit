part of '../grid.dart';

class LFStaggeredGrid extends StatelessWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final AxisDirection? axisDirection;
  final List<LFStaggeredGridTile> children;

  const LFStaggeredGrid({
    super.key,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.axisDirection,
    this.children = const <LFStaggeredGridTile>[],
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      axisDirection: axisDirection,
      children: children,
    );
  }
}

class LFStaggeredGridTile extends StatelessWidget {
  final int crossAxisCellCount;
  final num mainAxisCellCount;
  final Widget child;

  const LFStaggeredGridTile({
    super.key,
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: child,
    );
  }
}
