part of leaf_scroll_component;

class LeafScrollViewMaterial<T> extends StatelessWidget {
  final Widget child;
  final Key storageKey;
  final LeafScrollViewRefresh? onRefresh;
  final bool autoKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const LeafScrollViewMaterial({
    Key? key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.autoKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    final scrollView = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        if (autoKeyboardHide) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: SingleChildScrollView(
        key: storageKey,
        physics: AlwaysScrollableScrollPhysics(
          parent: physics ?? const ClampingScrollPhysics(),
        ),
        padding: padding,
        child: child,
      ),
    );

    if (onRefresh == null) {
      return scrollView;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: scrollView,
    );
  }
}
