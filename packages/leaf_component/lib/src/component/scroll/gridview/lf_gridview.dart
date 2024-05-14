part of '../scroll.dart';

class LFGridView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LFGridViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewLoadMore? onLoadMore;
  final LFScrollViewDidScroll? onDidScroll;
  final SliverGridDelegate? gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool hasReachedMax;

  const LFGridView({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    required this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.gridDelegate,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.hasReachedMax = true,
  });

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
        .listen((event) async {
      final type = event.type;
      final animated = event.animated;
      final position = event.position;
      final duration = event.duration ?? const Duration(milliseconds: 300);
      switch (type) {
        case LFScrollControllerEventType.scrollToPosition:
          setClampingPhysics();
          await scrollToPosition(
            context,
            animated: animated,
            value: position,
            animationDuration: duration,
          );
          resetPhysics();
          break;
        case LFScrollControllerEventType.scrollToTop:
          await scrollToTop(
            context,
            animated: animated,
            animationDuration: duration,
          );
          break;
        case LFScrollControllerEventType.scrollToBottom:
          await scrollToBottom(
            context,
            animated: animated,
            animationDuration: duration,
          );
          break;
        case LFScrollControllerEventType.loading:
          setLoading(animated);
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
  void setLoading(bool value) {
    super.setLoading(value);
    widget.controller?.isLoading = value;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        var scrollController = PrimaryScrollController.of(context);

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
      final gridView = LFGridViewMaterial(
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

      if (widget.disallowGlow) {
        return ScrollConfiguration(
          behavior: LFDisallowGlowBehavior(),
          child: gridView,
        );
      }

      return gridView;
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
