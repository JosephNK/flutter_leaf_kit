part of lf_scroll_component;

class LFScrollView extends StatefulWidget {
  final Key? storageKey;
  final Widget child;
  final bool autoKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool shrinkWrap; // Only Use LFScrollViewCupertino
  final bool scrollable;
  final LFScrollViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewDidScroll? onDidScroll;

  const LFScrollView({
    Key? key,
    this.storageKey,
    required this.child,
    required this.controller,
    this.autoKeyboardHide = false,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.onRefresh,
    this.onDidScroll,
  }) : super(key: key);

  @override
  State<LFScrollView> createState() => _LFScrollViewState();
}

class _LFScrollViewState extends State<LFScrollView> with LFScrollControlMixin {
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
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  void didScroll(LFScrollInfoData scrollData) {
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
      return LFScrollViewMaterial(
        storageKey: widget.storageKey,
        onRefresh: (widget.onRefresh != null)
            ? () async {
                await onPullToRefresh(context, widget.onRefresh);
              }
            : null,
        physics: widget.physics,
        padding: widget.padding,
        scrollable: widget.scrollable,
        child: widget.child,
      );
    }

    return LFScrollViewCupertino(
      storageKey: widget.storageKey,
      onRefresh: (widget.onRefresh != null)
          ? () async {
              await onPullToRefresh(context, widget.onRefresh);
            }
          : null,
      physics: widget.physics,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      scrollable: widget.scrollable,
      child: widget.child,
    );
  }
}
