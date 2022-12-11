part of lf_scroll_component;

class LFListView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final LFScrollViewRefresh? onRefresh;
  final List<T> items;
  final LFListViewController? controller;
  final LFScrollViewLoadMore? onLoadMore;
  final LFScrollViewDidScroll? onDidScroll;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool hasReachedMax;

  const LFListView({
    Key? key,
    this.storageKey,
    required this.builder,
    required this.onRefresh,
    required this.items,
    required this.controller,
    this.onLoadMore,
    this.onDidScroll,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.shrinkWrap = false,
    this.hasReachedMax = false,
  }) : super(key: key);

  @override
  State<LFListView<T>> createState() => _LFListViewState<T>();
}

class _LFListViewState<T> extends State<LFListView<T>>
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
  void didUpdateWidget(covariant LFListView<T> oldWidget) {
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
      return LFListViewMaterial(
        builder: widget.builder,
        storageKey: widget.storageKey,
        onRefresh: () async {
          await onPullToRefresh(context, widget.onRefresh);
        },
        items: widget.items,
        loading: loading,
        header: widget.header,
        padding: widget.padding,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
      );
    }

    return LFListViewCupertino(
      builder: widget.builder,
      storageKey: widget.storageKey,
      onRefresh: () async {
        await onPullToRefresh(context, widget.onRefresh);
      },
      items: widget.items,
      loading: loading,
      header: widget.header,
      padding: widget.padding,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
    );
  }
}
