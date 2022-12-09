part of leaf_scroll_component;

class LeafGridView<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key storageKey;
  final List<T> items;
  final LeafGridViewController? controller;
  final LeafScrollViewRefresh? onRefresh;
  final LeafScrollViewLoadMore? onLoadMore;
  final LeafScrollViewDidScroll? onDidScroll;
  final SliverGridDelegate? gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LeafGridView({
    Key? key,
    required this.builder,
    required this.storageKey,
    required this.items,
    required this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.gridDelegate,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.hasReachedMax = false,
  }) : super(key: key);

  @override
  State<LeafGridView> createState() => _LeafGridViewState<T>();
}

class _LeafGridViewState<T> extends State<LeafGridView<T>>
    with LeafScrollViewMixin {
  @override
  void initState() {
    super.initState();

    widget.controller?.scrollToTop = scrollToTop;
    widget.controller?.setLoading = setLoading;

    setReachedMax(widget.hasReachedMax);
  }

  @override
  void dispose() {
    widget.controller?.scrollToTop = null;
    widget.controller?.setLoading = null;

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LeafGridView<T> oldWidget) {
    if (oldWidget.hasReachedMax != widget.hasReachedMax) {
      setReachedMax(widget.hasReachedMax);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didScroll(LeafScrollData scrollData) {
    widget.onDidScroll?.call(scrollData);
  }

  @override
  void loadMore() async {
    await onPullToLoadMore(context, widget.onLoadMore);
  }

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
      return LeafGridViewMaterial(
        builder: widget.builder,
        storageKey: widget.storageKey,
        onRefresh: (widget.onRefresh != null)
            ? () async {
                await onPullToRefresh(context, widget.onRefresh);
              }
            : null,
        items: widget.items,
        loading: loading,
        gridDelegate: widget.gridDelegate,
        header: widget.header,
        padding: widget.padding,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        scrollable: widget.scrollable,
      );
    }

    return LeafGridViewCupertino(
      builder: widget.builder,
      storageKey: widget.storageKey,
      onRefresh: (widget.onRefresh != null)
          ? () async {
              await onPullToRefresh(context, widget.onRefresh);
            }
          : null,
      items: widget.items,
      loading: loading,
      gridDelegate: widget.gridDelegate,
      header: widget.header,
      padding: widget.padding,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      scrollable: widget.scrollable,
    );
  }
}
