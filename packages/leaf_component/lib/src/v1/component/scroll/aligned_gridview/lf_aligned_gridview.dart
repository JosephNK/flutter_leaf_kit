part of '../scroll.dart';

@Deprecated('Use LeafAlignedGridView instead.')
class LFAlignedGridView<T> extends StatefulWidget {
  final Key? storageKey;
  final Widget Function(BuildContext context, T item, int index) builder;
  final List<T> items;
  final LFAlignedGridViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewLoadMore? onLoadMore;
  final LFScrollViewDidScroll? onDidScroll;
  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool disallowGlow;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool shrinkWrap;
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool hasReachedMax;

  const LFAlignedGridView({
    super.key,
    this.storageKey,
    required this.builder,
    required this.items,
    required this.controller,
    required this.gridDelegate,
    this.onRefresh,
    this.onLoadMore,
    this.onDidScroll,
    this.header,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.scrollable = true,
    this.enableTapUnFocus = false,
    this.hasReachedMax = true,
  });

  @override
  State<LFAlignedGridView> createState() => _LFAlignedGridViewState<T>();
}

class _LFAlignedGridViewState<T> extends State<LFAlignedGridView<T>>
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
      final mContext = context;
      switch (type) {
        case LFScrollControllerEventType.scrollToPosition:
          setClampingPhysics();
          if (mContext.mounted) {
            await scrollToPosition(
              mContext,
              animated: animated,
              value: position,
              animationDuration: duration,
            );
          }
          resetPhysics();
          break;
        case LFScrollControllerEventType.scrollToTop:
          if (mContext.mounted) {
            await scrollToTop(
              mContext,
              animated: animated,
              animationDuration: duration,
            );
          }
          break;
        case LFScrollControllerEventType.scrollToBottom:
          if (mContext.mounted) {
            await scrollToBottom(
              mContext,
              animated: animated,
              animationDuration: duration,
            );
          }
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
  void didUpdateWidget(covariant LFAlignedGridView<T> oldWidget) {
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
      final gridView = LFAlignedGridViewMaterial(
        builder: widget.builder,
        storageKey: widget.storageKey,
        onRefresh: (widget.onRefresh != null)
            ? () async {
                await onPullToRefresh(context, widget.onRefresh);
              }
            : null,
        gridDelegate: widget.gridDelegate,
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
          child: gridView,
        );
      }

      return gridView;
    }

    return LFAlignedGridViewCupertino(
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
      hasReachedMax: widget.hasReachedMax,
    );
  }
}
