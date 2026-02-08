import 'dart:math';

import 'package:flutter/material.dart';

/// A 3D card-flip animation toggling between [front] and [rear] widgets.
///
/// Tap toggles the face. Uses [AnimatedSwitcher] with perspective rotation.
class LeafFlipAnimated extends StatefulWidget {
  final Widget front;
  final Widget rear;
  final bool showFrontSide;
  final ValueChanged<bool>? onChanged;

  const LeafFlipAnimated({
    super.key,
    required this.front,
    required this.rear,
    this.showFrontSide = true,
    this.onChanged,
  });

  @override
  State<LeafFlipAnimated> createState() => _LeafFlipAnimatedState();
}

class _LeafFlipAnimatedState extends State<LeafFlipAnimated> {
  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = widget.showFrontSide;
  }

  @override
  void didUpdateWidget(covariant LeafFlipAnimated oldWidget) {
    if (oldWidget.showFrontSide != widget.showFrontSide ||
        _showFrontSide != widget.showFrontSide) {
      setState(() {
        _showFrontSide = widget.showFrontSide;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final value = !_showFrontSide;
        setState(() {
          _showFrontSide = value;
        });
        widget.onChanged?.call(value);
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide
            ? Container(key: const ValueKey(true), child: widget.front)
            : Container(key: const ValueKey(false), child: widget.rear),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, child) {
        final isUnder = ValueKey(_showFrontSide) != child!.key;
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder
            ? min(rotateAnim.value, pi / 2)
            : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
