part of lf_animated;

enum LFAnimationStatus { forward, stop, reverse, repeat }

class LFAnimationController extends ChangeNotifier {
  late AnimationController animationController;

  final bool autoAnimation;
  final int repeatCount;
  final Duration duration;

  LFAnimationController({
    this.autoAnimation = false,
    this.repeatCount = -1,
    this.duration = const Duration(milliseconds: 250),
  });

  LFAnimationStatus status = LFAnimationStatus.stop;

  TickerFuture _tickerFuture = TickerFuture.complete();

  AnimationController initAnimationController({
    required TickerProvider vsync,
  }) {
    animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );
    return animationController;
  }

  TickerFuture forward() {
    status = LFAnimationStatus.forward;
    notifyListeners();
    _tickerFuture = animationController.forward();
    return _tickerFuture;
  }

  TickerFuture reverse() {
    status = LFAnimationStatus.reverse;
    notifyListeners();
    _tickerFuture = animationController.reverse();
    return _tickerFuture;
  }

  TickerFuture repeat() {
    status = LFAnimationStatus.repeat;
    notifyListeners();
    _tickerFuture = animationController.repeat();
    if (repeatCount != -1) {
      _tickerFuture.timeout(
          Duration(milliseconds: duration.inMilliseconds * repeatCount),
          onTimeout: () {
        animationController.forward(from: 0);
        animationController.stop(canceled: true);
      });
    }
    return _tickerFuture;
  }

  void stop() {
    status = LFAnimationStatus.stop;
    notifyListeners();
    animationController.stop();
  }

  TickerFuture forwardWithStop() {
    status = LFAnimationStatus.stop;
    notifyListeners();
    final value = animationController.value;
    _tickerFuture = animationController.forward(from: value);
    return _tickerFuture;
  }

  @override
  void dispose() {
    Logging.d('LFAnimationController dispose');
    animationController.dispose();
    super.dispose();
  }
}

class LFRotateAnimationController extends LFAnimationController {
  final double degree;

  LFRotateAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
    this.degree = pi,
  }) : super(
          autoAnimation: autoAnimation,
          repeatCount: repeatCount,
          duration: duration,
        );
}

class LFFadeAnimationController extends LFAnimationController {
  final bool isDisappear;

  LFFadeAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
    this.isDisappear = false,
  }) : super(
          autoAnimation: autoAnimation,
          repeatCount: repeatCount,
          duration: duration,
        );
}

class LFExpandAnimationController extends LFAnimationController {
  final bool expand;

  LFExpandAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
    this.expand = false,
  }) : super(
          autoAnimation: autoAnimation,
          repeatCount: repeatCount,
          duration: duration,
        );
}

class LFBouncingAnimationController extends LFAnimationController {
  LFBouncingAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
  }) : super(
          autoAnimation: autoAnimation,
          repeatCount: repeatCount,
          duration: duration,
        );
}

class LFScaleAnimationController extends LFAnimationController {
  LFScaleAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
  }) : super(
          autoAnimation: autoAnimation,
          repeatCount: repeatCount,
          duration: duration,
        );
}
