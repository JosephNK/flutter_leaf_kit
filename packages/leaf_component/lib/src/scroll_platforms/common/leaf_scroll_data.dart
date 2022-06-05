part of leaf_scroll_component;

class LeafScrollData extends Equatable {
  final ScrollNotification scrollNotification;
  final double position;
  final ScrollDirection direction;
  final bool isEdgeTop;
  final bool isAppearTop;

  const LeafScrollData({
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
