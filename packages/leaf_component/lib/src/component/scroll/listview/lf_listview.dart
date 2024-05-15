part of '../scroll.dart';

class LFListView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LFListViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewLoadMore? onLoadMore;
  final LFScrollViewDidScroll? onDidScroll;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool disallowGlow;
  final bool shrinkWrap;
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool hasReachedMax;

  const LFListView({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    required this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.disallowGlow = false,
    this.scrollable = true,
    this.shrinkWrap = false,
    this.enableTapUnFocus = false,
    this.hasReachedMax = true,
  });

  @override
  State<LFListView<T>> createState() => _LFListViewState<T>();
}

class _LFListViewState<T> extends State<LFListView<T>>
    with LFScrollControlMixin {
  StreamSubscription<LFScrollControllerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();

    initControlMixin(widget.physics);

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
      child: GestureDetector(
        behavior: widget.enableTapUnFocus ? HitTestBehavior.opaque : null,
        onTap: widget.enableTapUnFocus
            ? () {
                FocusScope.of(context).unfocus();
              }
            : null,
        child: _buildPlatform(context),
      ),
    );
  }

  Widget _buildPlatform(BuildContext context) {
    if (Platform.isAndroid) {
      final listView = LFListViewMaterial(
        builder: widget.builder,
        storageKey: widget.storageKey,
        onRefresh: (widget.onRefresh != null)
            ? () async {
                await onPullToRefresh(context, widget.onRefresh);
              }
            : null,
        items: widget.items,
        loading: loading,
        header: widget.header,
        padding: widget.padding,
        physics: widget.physics,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        scrollable: widget.scrollable,
        shrinkWrap: widget.shrinkWrap,
        hasReachedMax: widget.hasReachedMax,
      );

      if (widget.disallowGlow) {
        return ScrollConfiguration(
          behavior: LFDisallowGlowBehavior(),
          child: listView,
        );
      }

      return listView;
    }

    return LFListViewCupertino(
      builder: widget.builder,
      storageKey: widget.storageKey,
      onRefresh: (widget.onRefresh != null)
          ? () async {
              await onPullToRefresh(context, widget.onRefresh);
            }
          : null,
      items: widget.items,
      loading: loading,
      header: widget.header,
      padding: widget.padding,
      physics: widget.physics,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      scrollable: widget.scrollable,
      shrinkWrap: widget.shrinkWrap,
      hasReachedMax: widget.hasReachedMax,
    );
  }
}
