import 'package:flutter/material.dart';

import '../controller/leaf_animation_controller.dart';

/// A bouncing (scale-up) animation widget.
///
/// Animates scale from 1.0 to 1.2 with an elastic curve.
class LeafBouncingAnimated extends StatefulWidget {
  final Widget child;
  final LeafBouncingAnimationController? controller;
  final bool? value;
  final Duration duration;
  final Curve curve;
  final bool enableInitAnimation;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LeafBouncingAnimated({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.elasticIn,
    this.enableInitAnimation = true,
    this.onAnimationStatus,
  });

  @override
  State<LeafBouncingAnimated> createState() => _LeafBouncingAnimatedState();
}

class _LeafBouncingAnimatedState extends State<LeafBouncingAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LeafBouncingAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController =
        widget.controller ??
        LeafBouncingAnimationController(
          autoAnimation: false,
          duration: widget.duration,
        );
    final ac = _innerController.initAnimationController(
      AnimationController(vsync: this, duration: _innerController.duration),
    );
    _animationController = ac;

    _animation = Tween(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: ac!, curve: widget.curve));
    _animation.addStatusListener(_onAnimationStatus);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_innerController.autoAnimation) {
        _runAutoAnimating();
      } else {
        _runManualAnimating(animated: widget.enableInitAnimation);
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
  void didUpdateWidget(covariant LeafBouncingAnimated oldWidget) {
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

  void _runAutoAnimating() async {
    final ctrl = widget.controller ?? _innerController;
    if (ctrl.repeatCount != -1) {
      ctrl.repeat();
    } else {
      await ctrl.forward();
      await ctrl.reverse();
    }
  }

  void _runManualAnimating({bool animated = true}) async {
    final ctrl = widget.controller ?? _innerController;
    final value = widget.value;
    if (value != null && animated) {
      if (value) {
        await ctrl.reverse();
        await ctrl.forward();
      } else {
        await ctrl.forward();
        await ctrl.reverse();
      }
    }
  }
}
