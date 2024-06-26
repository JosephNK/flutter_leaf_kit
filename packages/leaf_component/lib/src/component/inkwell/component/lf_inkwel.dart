part of '../lf_inkwell.dart';

class LFInkWell extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool disabled;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const LFInkWell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(0.0),
    this.decoration,
    this.width,
    this.height,
    this.disabled = false,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: borderRadius,
        child: Ink(
          padding: padding,
          width: width,
          height: height,
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}
