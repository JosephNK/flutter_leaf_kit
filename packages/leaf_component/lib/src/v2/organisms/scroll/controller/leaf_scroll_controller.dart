import '../common/leaf_scroll_controller_mixin.dart';

/// Unified scroll controller for all Leaf scroll widgets.
///
/// Exposes stream-based commands: [scrollToTop], [scrollToBottom],
/// [scrollToPosition], and [setLoadingState].
///
/// Usage:
/// ```dart
/// final controller = LeafScrollController();
/// // ...
/// controller.scrollToTop(animated: true);
/// // ...
/// controller.dispose();
/// ```
class LeafScrollController with LeafScrollControllerMixin {
  LeafScrollController() {
    initController();
  }

  void dispose() {
    disposeController();
  }
}
