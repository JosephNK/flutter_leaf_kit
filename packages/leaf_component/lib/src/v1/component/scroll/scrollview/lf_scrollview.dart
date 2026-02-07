part of '../scroll.dart';

@Deprecated('Use LeafScrollView instead.')
class LFScrollView extends StatefulWidget {
  final Key? storageKey;
  final Widget child;
  final bool dragKeyboardHide;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool disallowGlow;
  final bool shrinkWrap; // Only Use LFScrollViewCupertino
  final bool scrollable;
  final bool enableTapUnFocus;
  final bool reverse;
  final LFScrollViewController? controller;
  final LFScrollViewRefresh? onRefresh;
  final LFScrollViewDidScroll? onDidScroll;

  const LFScrollView({
    super.key,
    this.storageKey,
    required this.child,
    this.controller,
    this.dragKeyboardHide = false,
    this.physics,
    this.padding,
    this.disallowGlow = false,
    this.shrinkWrap = false,
    this.scrollable = true,
    this.enableTapUnFocus = false,
    this.reverse = false,
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
        reverse: widget.reverse,
        dragKeyboardHide: widget.dragKeyboardHide,
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
      reverse: widget.reverse,
      dragKeyboardHide: widget.dragKeyboardHide,
      child: widget.child,
    );
  }
}
