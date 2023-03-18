part of lf_scroll_component;

class LFScrollViewMaterial<T> extends StatelessWidget {
  final Widget child;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final bool autoKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool scrollable;

  const LFScrollViewMaterial({
    Key? key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.autoKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.scrollable = true,
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
        keyboardDismissBehavior: autoKeyboardHide
            ? ScrollViewKeyboardDismissBehavior.onDrag
            : ScrollViewKeyboardDismissBehavior.manual,
        physics: scrollable
            ? AlwaysScrollableScrollPhysics(
                parent: physics ?? const BouncingScrollPhysics(),
              )
            : const NeverScrollableScrollPhysics(),
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
