part of lf_scroll_common;

class LFScrollInfoData extends Equatable {
  final ScrollNotification scrollNotification;
  final double position;
  final ScrollDirection direction;
  final bool isEdgeTop;
  final bool isAppearTop;

  const LFScrollInfoData({
    required this.scrollNotification,
    required this.position,
    required this.direction,
    required this.isEdgeTop,
    required this.isAppearTop,
  });

  @override
  List<Object?> get props => [
        scrollNotification,
        position,
        direction,
        isEdgeTop,
        isAppearTop,
      ];
}
