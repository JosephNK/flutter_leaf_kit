import 'dart:async';

/// Event types dispatched through [LeafScrollControllerMixin].
enum LeafScrollControllerEventType {
  scrollToPosition,
  scrollToTop,
  scrollToBottom,
  loading,
}

/// An event emitted by a scroll controller to command scrollable widgets.
class LeafScrollControllerEvent {
  final LeafScrollControllerEventType type;
  final bool animated;
  final double? position;
  final Duration? duration;

  LeafScrollControllerEvent(
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
mixin LeafScrollControllerMixin {
  late StreamController<LeafScrollControllerEvent> _streamController;
  late bool isLoading;

  Stream<LeafScrollControllerEvent> get stream =>
      _streamController.stream.asBroadcastStream();

  void initController() {
    _streamController =
        StreamController<LeafScrollControllerEvent>.broadcast();
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
      LeafScrollControllerEvent(
        LeafScrollControllerEventType.scrollToPosition,
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
      LeafScrollControllerEvent(
        LeafScrollControllerEventType.scrollToTop,
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
      LeafScrollControllerEvent(
        LeafScrollControllerEventType.scrollToBottom,
        animated: animated,
        duration: animationDuration,
      ),
    );
  }

  void setLoadingState({bool value = false}) {
    _addEvent(
      LeafScrollControllerEvent(
        LeafScrollControllerEventType.loading,
        animated: value,
      ),
    );
  }

  void _addEvent(LeafScrollControllerEvent event) {
    _streamController.sink.add(event);
  }
}
