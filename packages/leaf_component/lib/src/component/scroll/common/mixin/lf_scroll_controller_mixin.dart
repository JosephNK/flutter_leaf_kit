part of '../lf_scroll_common.dart';

enum LFScrollControllerEventType {
  scrollToTop,
  scrollToBottom,
  loading,
}

class LFScrollControllerEvent {
  final LFScrollControllerEventType type;
  final bool value;
  final Duration? duration;

  LFScrollControllerEvent(this.type, {this.value = false, this.duration});
}

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

  void scrollToTop({
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    addEvent(
      LFScrollControllerEvent(LFScrollControllerEventType.scrollToTop,
          value: animated, duration: animationDuration),
    );
  }

  void scrollToBottom({
    bool animated = false,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    addEvent(
      LFScrollControllerEvent(LFScrollControllerEventType.scrollToBottom,
          value: animated, duration: animationDuration),
    );
  }

  void loading({bool value = false}) {
    addEvent(
      LFScrollControllerEvent(LFScrollControllerEventType.loading,
          value: value),
    );
  }

  void addEvent(LFScrollControllerEvent event) {
    streamController?.sink.add(event);
  }
}
