part of '../animated.dart';

@Deprecated('Use LFAnimationControllerV2 instead')
enum LFAnimationStatus { forward, stop, reverse, repeat }

@Deprecated('Use LFAnimationControllerV2 instead')
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
        },
      );
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

@Deprecated('Use LFRotateAnimationControllerV2 instead')
class LFRotateAnimationController extends LFAnimationController {
  final double degree;

  LFRotateAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.degree = pi,
  });
}

@Deprecated('Use LFFadeAnimationControllerV2 instead')
class LFFadeAnimationController extends LFAnimationController {
  final bool isDisappear;

  LFFadeAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.isDisappear = false,
  });
}

@Deprecated('Use LFExpandAnimationControllerV2 instead')
class LFExpandAnimationController extends LFAnimationController {
  LFExpandAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

@Deprecated('Use LFBouncingAnimationControllerV2 instead')
class LFBouncingAnimationController extends LFAnimationController {
  LFBouncingAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

@Deprecated('Use LFScaleAnimationControllerV2 instead')
class LFScaleAnimationController extends LFAnimationController {
  LFScaleAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}
