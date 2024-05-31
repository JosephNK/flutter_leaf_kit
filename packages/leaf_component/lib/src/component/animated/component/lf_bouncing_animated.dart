part of '../animated.dart';

class LFBouncingAnimated extends StatefulWidget {
  final Widget child;
  final LFBouncingAnimationController? controller;
  final bool? value;
  final Duration duration;
  final Curve curve;
  final bool enableInitAnimation;
  final ValueChanged<AnimationStatus>? onAnimationStatus;

  const LFBouncingAnimated({
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
  State<LFBouncingAnimated> createState() => _LFBouncingAnimatedState();
}

class _LFBouncingAnimatedState extends State<LFBouncingAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;
  late Animation<double> _animation;
  late LFBouncingAnimationController _innerController;

  @override
  void initState() {
    super.initState();

    _innerController = widget.controller ??
        LFBouncingAnimationController(
          autoAnimation: false,
          duration: widget.duration,
        );
    final controller = _innerController;
    final autoAnimation = controller.autoAnimation;
    final duration = controller.duration;
    final animationController = controller.initAnimationController(
      AnimationController(vsync: this, duration: duration),
    );
    _animationController = animationController;

    controller.addListener(() async {
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

    _animation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: animationController!, curve: widget.curve),
    );
    _animation.addStatusListener(animationCallback);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (autoAnimation) {
        runAutoAnimating();
      } else {
        runManualAnimating(animated: widget.enableInitAnimation);
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
  void didUpdateWidget(covariant LFBouncingAnimated oldWidget) {
    if (oldWidget.value != widget.value) {
      runManualAnimating();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  void animationCallback(AnimationStatus status) {
    widget.onAnimationStatus?.call(status);
  }

  void runAutoAnimating() async {
    final controller = widget.controller ?? _innerController;
    final repeatCount = controller.repeatCount;
    if (repeatCount != -1) {
      controller.repeat();
    } else {
      await controller.forward();
      await controller.reverse();
    }
  }

  void runManualAnimating({bool animated = true}) async {
    final controller = widget.controller ?? _innerController;
    final value = widget.value;
    if (value != null && animated) {
      if (value) {
        await controller.reverse();
        await controller.forward();
      } else {
        await controller.forward();
        await controller.reverse();
      }
    }
  }
}
