import 'package:flutter/material.dart';

import '../controller/leaf_animation_controller.dart';

/// A rotation animation widget.
///
/// Rotates from 0 to [degree] radians (default pi).
class LeafRotateAnimated extends StatefulWidget {
  final Widget child;
  final LeafRotateAnimationController? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LeafRotateAnimated({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  });

  @override
  State<LeafRotateAnimated> createState() => _LeafRotateAnimatedState();
}

class _LeafRotateAnimatedState extends State<LeafRotateAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LeafRotateAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController =
        widget.controller ??
        LeafRotateAnimationController(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final degree = _innerController.degree;
    final ac = _innerController.initAnimationController(
      AnimationController(vsync: this, duration: _innerController.duration),
    );
    _animationController = ac;

    _animation = Tween(begin: 0.0, end: degree).animate(ac!);
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
  void didUpdateWidget(covariant LeafRotateAnimated oldWidget) {
    if (oldWidget.value != widget.value) {
      _runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.rotate(angle: _animation.value, child: widget.child);
      },
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
