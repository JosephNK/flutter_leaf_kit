import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// A V2 wrapper around [StaggeredGrid.count] for staggered grid layouts.
///
/// No theme required — this is a structural layout widget.
@immutable
class LFStaggeredGridV2 extends StatelessWidget {
  /// Number of cells in the cross axis.
  final int crossAxisCount;

  /// Spacing between tiles along the main axis.
  final double mainAxisSpacing;

  /// Spacing between tiles along the cross axis.
  final double crossAxisSpacing;

  /// Optional axis direction override.
  final AxisDirection? axisDirection;

  /// The grid tiles to render.
  final List<LFStaggeredGridTileV2> children;

  const LFStaggeredGridV2({
    super.key,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.axisDirection,
    this.children = const <LFStaggeredGridTileV2>[],
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

/// A V2 wrapper around [StaggeredGridTile.count].
///
/// Defines how many cells a single tile occupies in both axes.
@immutable
class LFStaggeredGridTileV2 extends StatelessWidget {
  /// Number of cells this tile spans across the cross axis.
  final int crossAxisCellCount;

  /// Number of cells this tile spans along the main axis.
  final num mainAxisCellCount;

  /// The content of this tile.
  final Widget child;

  const LFStaggeredGridTileV2({
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
