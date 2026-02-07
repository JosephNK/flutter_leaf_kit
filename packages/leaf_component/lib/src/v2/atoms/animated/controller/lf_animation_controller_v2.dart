import 'dart:math';

import 'package:flutter/material.dart';

/// Animation status for V2 animation controllers.
enum LFAnimationStatusV2 { forward, stop, reverse, repeat }

/// Base animation controller that wraps [AnimationController] with
/// auto-animation and repeat-count support.
class LFAnimationControllerV2 extends ChangeNotifier {
  AnimationController? animationController;

  final bool autoAnimation;
  final int repeatCount;
  final Duration duration;

  LFAnimationControllerV2({
    this.autoAnimation = false,
    this.repeatCount = -1,
    this.duration = const Duration(milliseconds: 250),
  });

  LFAnimationStatusV2 status = LFAnimationStatusV2.stop;
  TickerFuture _tickerFuture = TickerFuture.complete();

  AnimationController? initAnimationController(
      AnimationController controller) {
    animationController = controller;
    return animationController;
  }

  TickerFuture? forward({double? from}) {
    final ac = animationController;
    if (ac == null) return null;
    status = LFAnimationStatusV2.forward;
    notifyListeners();
    _tickerFuture = ac.forward(from: from);
    return _tickerFuture;
  }

  TickerFuture? reverse({double? from}) {
    final ac = animationController;
    if (ac == null) return null;
    status = LFAnimationStatusV2.reverse;
    notifyListeners();
    _tickerFuture = ac.reverse(from: from);
    return _tickerFuture;
  }

  TickerFuture? repeat() {
    final ac = animationController;
    if (ac == null) return null;
    status = LFAnimationStatusV2.repeat;
    notifyListeners();
    _tickerFuture = ac.repeat();
    if (repeatCount != -1) {
      _tickerFuture.timeout(
        Duration(milliseconds: duration.inMilliseconds * repeatCount),
        onTimeout: () {
          ac.forward(from: 0);
          ac.stop(canceled: true);
        },
      );
    }
    return _tickerFuture;
  }

  void stop() {
    final ac = animationController;
    if (ac == null) return;
    status = LFAnimationStatusV2.stop;
    notifyListeners();
    ac.stop();
  }
}

/// Rotation-specific controller with configurable [degree] (radians).
class LFRotateAnimationControllerV2 extends LFAnimationControllerV2 {
  final double degree;

  LFRotateAnimationControllerV2({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.degree = pi,
  });
}

/// Fade-specific controller with [isDisappear] flag.
class LFFadeAnimationControllerV2 extends LFAnimationControllerV2 {
  final bool isDisappear;

  LFFadeAnimationControllerV2({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.isDisappear = false,
  });
}

/// Expand-specific controller.
class LFExpandAnimationControllerV2 extends LFAnimationControllerV2 {
  LFExpandAnimationControllerV2({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

/// Bouncing-specific controller.
class LFBouncingAnimationControllerV2 extends LFAnimationControllerV2 {
  LFBouncingAnimationControllerV2({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

/// Scale-specific controller.
class LFScaleAnimationControllerV2 extends LFAnimationControllerV2 {
  LFScaleAnimationControllerV2({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}
