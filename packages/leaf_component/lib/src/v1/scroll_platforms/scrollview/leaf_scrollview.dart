part of leaf_scroll_component;

class LeafScrollView extends StatefulWidget {
  final Key storageKey;
  final Widget child;
  final bool autoKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool shrinkWrap; // Only Use LeafScrollViewCupertino
  final LeafScrollViewController? controller;
  final LeafScrollViewRefresh? onRefresh;
  final LeafScrollViewDidScroll? onDidScroll;

  const LeafScrollView({
    Key? key,
    required this.storageKey,
    required this.child,
    required this.controller,
    this.autoKeyboardHide = false,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.onRefresh,
    this.onDidScroll,
  }) : super(key: key);

  @override
  State<LeafScrollView> createState() => _LeafScrollViewState();
}

class _LeafScrollViewState extends State<LeafScrollView>
    with LeafScrollViewMixin {
  @override
  void initState() {
    super.initState();

    widget.controller?.scrollToTop = scrollToTop;
    widget.controller?.setLoading = setLoading;
  }

  @override
  void dispose() {
    widget.controller?.scrollToTop = null;
    widget.controller?.setLoading = null;

    super.dispose();
  }

  @override
  void didScroll(LeafScrollData scrollData) {
    widget.onDidScroll?.call(scrollData);
  }

  @override
  void loadMore() {}

  @override
  void scrollToTop(BuildContext context, {bool animated = false}) {
    super.scrollToTop(context, animated: animated);
  }

  @override
  void setLoading(bool value) {
    super.setLoading(value);
    widget.controller?.isLoading = value;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        var scrollController = PrimaryScrollController.of(context)!;

        final depth = scrollNotification.depth;

        if (depth > 0 || !scrollController.hasClients) {
          return false;
        }

        setScrollDirection(scrollNotification);

        return didScrollWithLoadMore(scrollNotification);
      },
      child: _buildPlatform(context),
    );
  }

  Widget _buildPlatform(BuildContext context) {
    if (Platform.isAndroid) {
      return LeafScrollViewMaterial(
        storageKey: widget.storageKey,
        onRefresh: widget.onRefresh == null
            ? null
            : () async {
                await onPullToRefresh(context, widget.onRefresh);
              },
        physics: widget.physics,
        padding: widget.padding,
        child: widget.child,
      );
    }

    return LeafScrollViewCupertino(
      storageKey: widget.storageKey,
      onRefresh: widget.onRefresh == null
          ? null
          : () async {
              await onPullToRefresh(context, widget.onRefresh);
            },
      physics: widget.physics,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      child: widget.child,
    );
  }
}
