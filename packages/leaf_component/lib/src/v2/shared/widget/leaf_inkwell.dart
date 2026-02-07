import 'package:flutter/material.dart';

/// A simple ink-well wrapper that provides a Material ripple effect.
///
/// Provides a Material ripple effect with optional decoration and padding.
@immutable
class LeafInkWell extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool disabled;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const LeafInkWell({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.width,
    this.height,
    this.disabled = false,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: disabled ? null : onTap,
          child: Ink(
            padding: padding,
            width: width,
            height: height,
            child: child,
          ),
        ),
      ),
    );
  }
}
