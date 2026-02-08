import 'dart:math';

import 'package:flutter/material.dart';

/// Animation status for Leaf animation controllers.
enum LeafAnimationStatus { forward, stop, reverse, repeat }

/// Base animation controller that wraps [AnimationController] with
/// auto-animation and repeat-count support.
class LeafAnimationController extends ChangeNotifier {
  AnimationController? animationController;

  final bool autoAnimation;
  final int repeatCount;
  final Duration duration;

  LeafAnimationController({
    this.autoAnimation = false,
    this.repeatCount = -1,
    this.duration = const Duration(milliseconds: 250),
  });

  LeafAnimationStatus status = LeafAnimationStatus.stop;
  TickerFuture _tickerFuture = TickerFuture.complete();

  AnimationController? initAnimationController(AnimationController controller) {
    animationController = controller;
    return animationController;
  }

  TickerFuture? forward({double? from}) {
    final ac = animationController;
    if (ac == null) return null;
    status = LeafAnimationStatus.forward;
    notifyListeners();
    _tickerFuture = ac.forward(from: from);
    return _tickerFuture;
  }

  TickerFuture? reverse({double? from}) {
    final ac = animationController;
    if (ac == null) return null;
    status = LeafAnimationStatus.reverse;
    notifyListeners();
    _tickerFuture = ac.reverse(from: from);
    return _tickerFuture;
  }

  TickerFuture? repeat() {
    final ac = animationController;
    if (ac == null) return null;
    status = LeafAnimationStatus.repeat;
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
    status = LeafAnimationStatus.stop;
    notifyListeners();
    ac.stop();
  }
}

/// Rotation-specific controller with configurable [degree] (radians).
class LeafRotateAnimationController extends LeafAnimationController {
  final double degree;

  LeafRotateAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.degree = pi,
  });
}

/// Fade-specific controller with [isDisappear] flag.
class LeafFadeAnimationController extends LeafAnimationController {
  final bool isDisappear;

  LeafFadeAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
    this.isDisappear = false,
  });
}

/// Expand-specific controller.
class LeafExpandAnimationController extends LeafAnimationController {
  LeafExpandAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

/// Bouncing-specific controller.
class LeafBouncingAnimationController extends LeafAnimationController {
  LeafBouncingAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}

/// Scale-specific controller.
class LeafScaleAnimationController extends LeafAnimationController {
  LeafScaleAnimationController({
    super.autoAnimation,
    super.repeatCount,
    super.duration,
  });
}
