part of '../lf_animated.dart';

class LFRotateAnimated extends StatefulWidget {
  final Widget child;
  final LFRotateAnimationController? controller;
  final bool? value;
  final Duration? duration;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFRotateAnimated({
    super.key,
    required this.child,
    this.controller,
    this.value,
    this.duration,
    this.onAnimationStatus,
  });

  @override
  State<LFRotateAnimated> createState() => _LFRotateAnimatedState();
}

class _LFRotateAnimatedState extends State<LFRotateAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation _animation;
  late LFRotateAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFRotateAnimationController(
          autoAnimation: false,
          duration: widget.duration ?? const Duration(milliseconds: 250),
        );
    final controller = _innerController;
    final autoAnimation = controller.autoAnimation;
    final degree = controller.degree;
    final duration = controller.duration;
    final animationController = controller.initAnimationController(
      AnimationController(vsync: this, duration: duration),
    );
    _animationController = animationController;

    controller.addListener(() {
      final status = controller.status;
      switch (status) {
        case LFAnimationStatus.forward:
          break;
        case LFAnimationStatus.stop:
          break;
        case LFAnimationStatus.reverse:
          break;
        case LFAnimationStatus.repeat:
          break;
      }
    });

    _animation = Tween(begin: 0.0, end: degree).animate(animationController!);
    _animation.addStatusListener(animationCallback);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (autoAnimation) {
        runAutoAnimating();
      } else {
        runManualAnimating();
      }
    });
  }

  @override
  void dispose() {
    _animation.removeStatusListener(animationCallback);
    _animationController?.stop();
    _animationController?.dispose();
    if (widget.controller == null) _innerController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFRotateAnimated oldWidget) {
    if (oldWidget.value != widget.value) {
      runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final animationController = controller?.animationController;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: widget.child,
        );
      },
    );
  }

  void animationCallback(AnimationStatus status) {
    widget.onAnimationStatus?.call(status);
  }

  void runAutoAnimating() {
    final controller = widget.controller ?? _innerController;
    final repeatCount = controller.repeatCount;
    if (repeatCount != -1) {
      controller.repeat();
    } else {
      controller.forward();
    }
  }

  void runManualAnimating() {
    final controller = widget.controller ?? _innerController;
    final value = widget.value;
    if (value != null) {
      if (value) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }
}
