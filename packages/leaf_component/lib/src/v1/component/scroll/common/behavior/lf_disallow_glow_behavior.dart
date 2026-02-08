part of '../lf_scroll_common.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFDisallowGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
