part of '../skeleton.dart';

class LFSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final double radius;
  final double baseOpacity;
  final double highlightOpacity;
  final bool random;

  const LFSkeleton({
    super.key,
    this.width,
    this.height,
    this.child,
    this.color,
    this.radius = 0.0,
    this.baseOpacity = 0.3,
    this.highlightOpacity = 0.1,
    this.random = false,
  });

  @override
  Widget build(BuildContext context) {
    final randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final baseColor = random
        ? randomColor.withOpacity(baseOpacity)
        : color?.withOpacity(baseOpacity) ??
            Colors.grey[300]?.withOpacity(baseOpacity) ??
            Colors.grey.withOpacity(baseOpacity);
    final highlightColor = random
        ? randomColor.withOpacity(highlightOpacity)
        : color?.withOpacity(highlightOpacity) ??
            Colors.grey[100]?.withOpacity(highlightOpacity) ??
            Colors.grey.withOpacity(highlightOpacity);

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
