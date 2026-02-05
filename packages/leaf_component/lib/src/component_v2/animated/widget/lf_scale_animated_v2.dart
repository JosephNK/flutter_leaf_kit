import 'package:flutter/material.dart';

import '../controller/lf_animation_controller_v2.dart';

/// A scale animation widget.
///
/// Animates scale from 0.0 to 1.0 with [Curves.easeInOutBack].
class LFScaleAnimatedV2 extends StatefulWidget {
  final Widget child;
  final LFScaleAnimationControllerV2? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFScaleAnimatedV2({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  });

  @override
  State<LFScaleAnimatedV2> createState() => _LFScaleAnimatedV2State();
}

class _LFScaleAnimatedV2State extends State<LFScaleAnimatedV2>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFScaleAnimationControllerV2 _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFScaleAnimationControllerV2(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final ac = _innerController.initAnimationController(
      AnimationController(vsync: this, duration: _innerController.duration),
    );
    _animationController = ac;

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: ac!, curve: Curves.easeInOutBack),
    );
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
  void didUpdateWidget(covariant LFScaleAnimatedV2 oldWidget) {
    if (oldWidget.value != widget.value) {
      _runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
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
