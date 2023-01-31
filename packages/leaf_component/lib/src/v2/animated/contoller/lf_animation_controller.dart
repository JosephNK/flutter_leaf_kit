part of lf_animated;

enum LFAnimationStatus { forward, stop, reverse, repeat }

class LFAnimationController extends ChangeNotifier {
  // Note: dispose at the place of use
  AnimationController? animationController;

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

  AnimationController? initAnimationController(AnimationController controller) {
    animationController = controller;
    return animationController;
  }

  TickerFuture? forward() {
    final animationController = this.animationController;
    if (animationController == null) return null;
    status = LFAnimationStatus.forward;
    notifyListeners();
    _tickerFuture = animationController.forward();
    return _tickerFuture;
  }

  TickerFuture? reverse() {
    final animationController = this.animationController;
    if (animationController == null) return null;
    status = LFAnimationStatus.reverse;
    notifyListeners();
    _tickerFuture = animationController.reverse();
    return _tickerFuture;
  }

  TickerFuture? repeat() {
    final animationController = this.animationController;
    if (animationController == null) return null;
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
    final animationController = this.animationController;
    if (animationController == null) return;
    status = LFAnimationStatus.stop;
    notifyListeners();
    animationController.stop();
  }

  TickerFuture? forwardWithStop() {
    final animationController = this.animationController;
    if (animationController == null) return null;
    status = LFAnimationStatus.stop;
    notifyListeners();
    final value = animationController.value;
    _tickerFuture = animationController.forward(from: value);
    return _tickerFuture;
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
  LFExpandAnimationController({
    bool autoAnimation = false,
    int repeatCount = -1,
    Duration duration = const Duration(milliseconds: 250),
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
