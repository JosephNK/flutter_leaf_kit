part of leaf_indicator_component;

class LeafCenterIndicator extends StatelessWidget {
  final LeafIndSize size;

  const LeafCenterIndicator({
    Key? key,
    this.size = LeafIndSize.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeafIndicator(
      size: size,
      useCenter: true,
    );
  }
}
