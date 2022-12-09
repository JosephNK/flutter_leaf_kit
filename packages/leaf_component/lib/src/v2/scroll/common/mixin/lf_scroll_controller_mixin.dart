part of lf_scroll_common;

enum LFScrollControllerEventType {
  scrollToTop,
  loading,
}

class LFScrollControllerEvent {
  final LFScrollControllerEventType type;
  final bool value;

  LFScrollControllerEvent(this.type, {this.value = false});
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

  void scrollToTop({bool animated = false}) {
    addEvent(
      LFScrollControllerEvent(LFScrollControllerEventType.scrollToTop,
          value: animated),
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
