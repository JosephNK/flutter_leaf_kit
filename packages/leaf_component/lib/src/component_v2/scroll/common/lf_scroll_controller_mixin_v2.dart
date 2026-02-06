import 'dart:async';

/// Event types dispatched through [LFScrollControllerMixinV2].
enum LFScrollControllerEventTypeV2 {
  scrollToPosition,
  scrollToTop,
  scrollToBottom,
  loading,
}

/// An event emitted by a scroll controller to command scrollable widgets.
class LFScrollControllerEventV2 {
  final LFScrollControllerEventTypeV2 type;
  final bool animated;
  final double? position;
  final Duration? duration;

  LFScrollControllerEventV2(
    this.type, {
    this.animated = false,
    this.position,
    this.duration,
  });
}

/// Mixin that provides stream-based scroll commands.
///
/// Apply to a controller class to expose [scrollToTop], [scrollToBottom],
/// [scrollToPosition], and [loading] commands that are consumed by scroll widgets.
mixin LFScrollControllerMixinV2 {
  late StreamController<LFScrollControllerEventV2> _streamController;
  late bool isLoading;

  Stream<LFScrollControllerEventV2> get stream =>
      _streamController.stream.asBroadcastStream();

  void initController() {
    _streamController =
        StreamController<LFScrollControllerEventV2>.broadcast();
    isLoading = false;
  }

  void disposeController() {
    _streamController.close();
    isLoading = false;
  }

  void scrollToPosition({
    bool animated = false,
    required double position,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    _addEvent(
      LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.scrollToPosition,
        animated: animated,
        position: position,
        duration: animationDuration,
      ),
    );
  }

  void scrollToTop({
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    _addEvent(
      LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.scrollToTop,
        animated: animated,
        duration: animationDuration,
      ),
    );
  }

  void scrollToBottom({
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    _addEvent(
      LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.scrollToBottom,
        animated: animated,
        duration: animationDuration,
      ),
    );
  }

  void setLoadingState({bool value = false}) {
    _addEvent(
      LFScrollControllerEventV2(
        LFScrollControllerEventTypeV2.loading,
        animated: value,
      ),
    );
  }

  void _addEvent(LFScrollControllerEventV2 event) {
    _streamController.sink.add(event);
  }
}
