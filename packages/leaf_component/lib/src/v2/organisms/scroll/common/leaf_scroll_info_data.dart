import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Immutable snapshot of scroll state passed to [LeafScrollViewDidScroll].
class LeafScrollInfoData {
  final ScrollNotification scrollNotification;
  final double position;
  final double maxScrollExtent;
  final ScrollDirection direction;
  final bool isEdgeTop;
  final bool isAppearTop;

  const LeafScrollInfoData({
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
      other is LeafScrollInfoData &&
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
