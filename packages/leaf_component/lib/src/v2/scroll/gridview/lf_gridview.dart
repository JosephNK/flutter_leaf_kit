part of lf_scroll_component;

class LFGridView<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T item, int index) builder;
  final Key storageKey;
  final List<T> items;
  final LFGridViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewLoadMore? onLoadMore;
  final LFScrollViewDidScroll? onDidScroll;
  final SliverGridDelegate? gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LFGridView({
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
  State<LFGridView> createState() => _LFGridViewState<T>();
}

class _LFGridViewState<T> extends State<LFGridView<T>>
    with LFScrollControlMixin {
  StreamSubscription<LFScrollControllerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = widget.controller?.streamController?.stream
        .asBroadcastStream()
        .listen((event) {
      final type = event.type;
      final value = event.value;
      switch (type) {
        case LFScrollControllerEventType.scrollToTop:
          scrollToTop(context, animated: value);
          break;
        case LFScrollControllerEventType.loading:
          setLoading(value);
          break;
      }
    });

    setReachedMax(widget.hasReachedMax);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFGridView<T> oldWidget) {
    if (oldWidget.hasReachedMax != widget.hasReachedMax) {
      setReachedMax(widget.hasReachedMax);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didScroll(LFScrollInfoData scrollData) {
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
      return LFGridViewMaterial(
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

    return LFGridViewCupertino(
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
