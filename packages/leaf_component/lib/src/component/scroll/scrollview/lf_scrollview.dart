part of '../scroll.dart';

class LFScrollView extends StatefulWidget {
  final Key? storageKey;
  final Widget child;
  final bool autoKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool disallowGlow;
  final bool shrinkWrap; // Only Use LFScrollViewCupertino
  final bool scrollable;
  final LFScrollViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewDidScroll? onDidScroll;

  const LFScrollView({
    super.key,
    this.storageKey,
    required this.child,
    this.controller,
    this.autoKeyboardHide = false,
    this.physics,
    this.padding,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.onRefresh,
    this.onDidScroll,
  });

  @override
  State<LFScrollView> createState() => _LFScrollViewState();
}

class _LFScrollViewState extends State<LFScrollView> with LFScrollControlMixin {
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
      final scrollView = LFScrollViewMaterial(
        storageKey: widget.storageKey,
        onRefresh: (widget.onRefresh != null)
            ? () async {
                await onPullToRefresh(context, widget.onRefresh);
              }
            : null,
        physics: currentPhysics,
        padding: widget.padding,
        scrollable: widget.scrollable,
        autoKeyboardHide: widget.autoKeyboardHide,
        child: widget.child,
      );

      if (widget.disallowGlow) {
        return ScrollConfiguration(
          behavior: LFDisallowGlowBehavior(),
          child: scrollView,
        );
      }

      return scrollView;
    }

    return LFScrollViewCupertino(
      storageKey: widget.storageKey,
      onRefresh: (widget.onRefresh != null)
          ? () async {
              await onPullToRefresh(context, widget.onRefresh);
            }
          : null,
      physics: currentPhysics,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      scrollable: widget.scrollable,
      autoKeyboardHide: widget.autoKeyboardHide,
      child: widget.child,
    );
  }
}
