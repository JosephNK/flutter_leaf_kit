part of lf_scroll_component;

class LFListViewIndicator extends StatelessWidget {
  final bool loading;

  const LFListViewIndicator({
    Key? key,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loading,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const Center(
          child: LFIndicator(size: LFIndicatorSize.medium),
        ),
      ),
    );
  }
}
