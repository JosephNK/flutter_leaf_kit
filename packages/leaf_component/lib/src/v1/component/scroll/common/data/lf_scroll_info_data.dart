part of '../lf_scroll_common.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFScrollInfoData extends Equatable {
  final ScrollNotification scrollNotification;
  final double position;
  final double maxScrollExtent;
  final ScrollDirection direction;
  final bool isEdgeTop;
  final bool isAppearTop;

  const LFScrollInfoData({
    required this.scrollNotification,
    required this.position,
    required this.maxScrollExtent,
    required this.direction,
    required this.isEdgeTop,
    required this.isAppearTop,
  });

  @override
  List<Object?> get props => [
    scrollNotification,
    position,
    maxScrollExtent,
    direction,
    isEdgeTop,
    isAppearTop,
  ];
}
