import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Immutable snapshot of scroll state passed to [LFScrollViewDidScrollV2].
class LFScrollInfoDataV2 {
  final ScrollNotification scrollNotification;
  final double position;
  final double maxScrollExtent;
  final ScrollDirection direction;
  final bool isEdgeTop;
  final bool isAppearTop;

  const LFScrollInfoDataV2({
    required this.scrollNotification,
    required this.position,
    required this.maxScrollExtent,
    required this.direction,
    required this.isEdgeTop,
    required this.isAppearTop,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LFScrollInfoDataV2 &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          maxScrollExtent == other.maxScrollExtent &&
          direction == other.direction &&
          isEdgeTop == other.isEdgeTop &&
          isAppearTop == other.isAppearTop;

  @override
  int get hashCode => Object.hash(
        position,
        maxScrollExtent,
        direction,
        isEdgeTop,
        isAppearTop,
      );
}
