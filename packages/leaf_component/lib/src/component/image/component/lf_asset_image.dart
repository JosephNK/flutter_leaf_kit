part of lf_image;

class LFAssetImage extends StatelessWidget {
  final String? path;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const LFAssetImage({
    Key? key,
    required this.path,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    final width = this.width;
    final height = this.height;
    final fit = this.fit;

    if (path == null) {
      return Container();
    }

    return SizedBox(
      width: width,
      height: height,
      child: Image(
        image: AssetImage(path),
        fit: fit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }
          return LFSkeleton(color: color);
        },
      ),
    );
  }
}
