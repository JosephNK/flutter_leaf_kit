part of '../lf_scroll_common.dart';

@Deprecated('V1 component deprecated. Use V2 components instead.')
enum LFScrollControllerEventType {
  scrollToPosition,
  scrollToTop,
  scrollToBottom,
  loading,
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
class LFScrollControllerEvent {
  final LFScrollControllerEventType type;
  final bool animated;
  final double? position;
  final Duration? duration;

  LFScrollControllerEvent(
    this.type, {
    this.animated = false,
    this.position,
    this.duration,
  });
}

@Deprecated('V1 component deprecated. Use V2 components instead.')
mixin LFScrollControllerMixin {
  late StreamController<LFScrollControllerEvent>? streamController;
  late bool isLoading;

  void init() {
    streamController = StreamController<LFScrollControllerEvent>.broadcast();
  }

  void tearDown() {
    streamController?.close();
    isLoading = false;
  }

  void scrollToPosition({
    bool animated = false,
    required double position,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    addEvent(
      LFScrollControllerEvent(
        LFScrollControllerEventType.scrollToPosition,
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
    addEvent(
      LFScrollControllerEvent(
        LFScrollControllerEventType.scrollToTop,
        animated: animated,
        duration: animationDuration,
      ),
    );
  }

  void scrollToBottom({
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    addEvent(
      LFScrollControllerEvent(
        LFScrollControllerEventType.scrollToBottom,
        animated: animated,
        duration: animationDuration,
      ),
    );
  }

  void loading({bool value = false}) {
    addEvent(
      LFScrollControllerEvent(
        LFScrollControllerEventType.loading,
        animated: value,
      ),
    );
  }

  void addEvent(LFScrollControllerEvent event) {
    streamController?.sink.add(event);
  }
}
