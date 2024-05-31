part of '../skeleton.dart';

class LFSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Color? baseColor;
  final Color? highlightColor;
  final double baseOpacity;
  final double highlightOpacity;
  final Widget? child;

  const LFSkeleton({
    super.key,
    this.width,
    this.height,
    this.radius = 0.0,
    this.baseColor,
    this.highlightColor,
    this.baseOpacity = 0.3,
    this.highlightOpacity = 0.1,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = (this.baseColor ?? Colors.grey[300] ?? Colors.grey)
        .withOpacity(baseOpacity);
    final highlightColor =
        (this.highlightColor ?? Colors.grey[100] ?? Colors.grey)
            .withOpacity(highlightOpacity);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
          ),
    );
  }
}
