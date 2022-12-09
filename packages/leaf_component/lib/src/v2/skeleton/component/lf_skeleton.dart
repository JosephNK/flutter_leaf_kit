part of lf_skeleton;

class LFSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final bool random;

  const LFSkeleton({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.color,
    this.random = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final baseColor = random
        ? randomColor.withOpacity(0.3)
        : color?.withOpacity(0.3) ?? Colors.grey[300] ?? Colors.grey;
    final highlightColor = random
        ? randomColor.withOpacity(0.1)
        : color?.withOpacity(0.1) ?? Colors.grey[100] ?? Colors.grey;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child ??
          Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
    );
  }
}
