import '../common/lf_scroll_controller_mixin_v2.dart';

/// Unified scroll controller for all V2 scroll widgets.
///
/// Exposes stream-based commands: [scrollToTop], [scrollToBottom],
/// [scrollToPosition], and [setLoadingState].
///
/// Usage:
/// ```dart
/// final controller = LFScrollControllerV2();
/// // ...
/// controller.scrollToTop(animated: true);
/// // ...
/// controller.dispose();
/// ```
class LFScrollControllerV2 with LFScrollControllerMixinV2 {
  LFScrollControllerV2() {
    initController();
  }

  void dispose() {
    disposeController();
  }
}
