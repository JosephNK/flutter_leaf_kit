import 'package:flutter/widgets.dart';

/// A [ScrollBehavior] that suppresses the overscroll glow indicator.
///
/// Wrap a scrollable widget with [ScrollConfiguration] using this behavior
/// to remove the glow effect on Android:
/// ```dart
/// ScrollConfiguration(
///   behavior: LeafDisallowGlowBehavior(),
///   child: ListView(...),
/// )
/// ```
class LeafDisallowGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
