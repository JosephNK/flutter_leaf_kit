part of lf_image;

class LFAssetImage extends StatelessWidget {
  final String? path;
  final Color? color;

  const LFAssetImage({
    Key? key,
    required this.path,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    if (path == null) {
      return Container();
    }
    return Image(
      image: AssetImage(path),
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return LFSkeleton(color: color);
      },
    );
  }
}
