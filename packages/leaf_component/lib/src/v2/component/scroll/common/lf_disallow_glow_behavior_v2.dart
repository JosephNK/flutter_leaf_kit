import 'package:flutter/widgets.dart';

/// A [ScrollBehavior] that suppresses the overscroll glow indicator.
///
/// Wrap a scrollable widget with [ScrollConfiguration] using this behavior
/// to remove the glow effect on Android:
/// ```dart
/// ScrollConfiguration(
///   behavior: LFDisallowGlowBehaviorV2(),
///   child: ListView(...),
/// )
/// ```
class LFDisallowGlowBehaviorV2 extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
