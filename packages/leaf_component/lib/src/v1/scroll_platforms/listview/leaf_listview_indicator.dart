part of leaf_scroll_component;

class LeafListViewIndicator extends StatelessWidget {
  final bool loading;

  const LeafListViewIndicator({
    Key? key,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const LeafCenterIndicator(),
      ),
    );
  }
}
