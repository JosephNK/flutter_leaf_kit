import 'package:flutter/material.dart';

import '../controller/lf_animation_controller_v2.dart';

/// A vertical expand/collapse animation widget.
///
/// Uses [SizeTransition] to animate size along the vertical axis.
class LFExpandAnimatedV2 extends StatefulWidget {
  final Widget child;
  final LFExpandAnimationControllerV2? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFExpandAnimatedV2({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  });

  @override
  State<LFExpandAnimatedV2> createState() => _LFExpandAnimatedV2State();
}

class _LFExpandAnimatedV2State extends State<LFExpandAnimatedV2>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFExpandAnimationControllerV2 _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFExpandAnimationControllerV2(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final ac = _innerController.initAnimationController(
      AnimationController(vsync: this, duration: _innerController.duration),
    );
    _animationController = ac;

    _animation = CurvedAnimation(parent: ac!, curve: Curves.ease);
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
  void didUpdateWidget(covariant LFExpandAnimatedV2 oldWidget) {
    if (oldWidget.value != widget.value) {
      _runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final expand =
        _innerController.status == LFAnimationStatusV2.forward;

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: expand ? 1.0 : -1.0,
      sizeFactor: _animation,
      child: widget.child,
    );
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
