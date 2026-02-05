import 'package:flutter/material.dart';

import '../controller/lf_animation_controller_v2.dart';

/// A fade (opacity) animation widget.
///
/// Fades in (0→1) or out (1→0) depending on the controller's [isDisappear].
class LFFadeAnimatedV2 extends StatefulWidget {
  final Widget child;
  final LFFadeAnimationControllerV2? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFFadeAnimatedV2({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  });

  @override
  State<LFFadeAnimatedV2> createState() => _LFFadeAnimatedV2State();
}

class _LFFadeAnimatedV2State extends State<LFFadeAnimatedV2>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFFadeAnimationControllerV2 _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFFadeAnimationControllerV2(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final isDisappear = _innerController.isDisappear;
    final ac = _innerController.initAnimationController(
      AnimationController(vsync: this, duration: _innerController.duration),
    );
    _animationController = ac;

    if (!isDisappear) {
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: ac!, curve: Curves.easeIn),
      );
    } else {
      _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: ac!, curve: Curves.easeOut),
      );
    }
    _animation.addStatusListener(_onAnimationStatus);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_innerController.autoAnimation) {
        _runAutoAnimating();
      } else {
        _runManualAnimating();
      }
    });
  }

  @override
  void dispose() {
    _animation.removeStatusListener(_onAnimationStatus);
    _animationController?.stop();
    _animationController?.dispose();
    if (widget.controller == null) _innerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFFadeAnimatedV2 oldWidget) {
    if (oldWidget.value != widget.value) {
      _runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }

  void _onAnimationStatus(AnimationStatus status) {
    widget.onAnimationStatus?.call(status);
  }

  void _runAutoAnimating() {
    final ctrl = widget.controller ?? _innerController;
    if (ctrl.repeatCount != -1) {
      ctrl.repeat();
    } else {
      ctrl.forward();
    }
  }

  void _runManualAnimating() {
    final ctrl = widget.controller ?? _innerController;
    final value = widget.value;
    if (value != null) {
      if (value) {
        ctrl.forward();
      } else {
        ctrl.reverse();
      }
    }
  }
}
