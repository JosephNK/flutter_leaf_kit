part of '../scroll.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFScrollViewMaterial<T> extends StatelessWidget {
  final Widget child;
  final Key? storageKey;
  final LFScrollViewRefresh? onRefresh;
  final bool dragKeyboardHide;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool scrollable;
  final bool reverse;

  const LFScrollViewMaterial({
    super.key,
    required this.child,
    required this.storageKey,
    required this.onRefresh,
    this.dragKeyboardHide = false,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.scrollable = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return _buildMaterialListView(context);
  }

  Widget _buildMaterialListView(BuildContext context) {
    final scrollView = SingleChildScrollView(
      key: storageKey,
      keyboardDismissBehavior: dragKeyboardHide
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      physics: scrollable
          ? AlwaysScrollableScrollPhysics(
              parent: physics ?? const BouncingScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      padding: padding,
      reverse: reverse,
      child: child,
    );

    if (onRefresh == null) {
      return scrollView;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh?.call();
      },
      child: scrollView,
    );
  }
}
