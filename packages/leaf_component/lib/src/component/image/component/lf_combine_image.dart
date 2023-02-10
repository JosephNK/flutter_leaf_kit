part of lf_image;

class LFCombineImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFCombineImage({
    Key? key,
    required this.url,
    this.width = 45.0,
    this.height = 45.0,
    this.fit = BoxFit.cover,
    this.placeholderWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isURL(url)) {
      return LFAssetImage(
        path: url,
        width: width,
        height: height,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    return LFCacheImage(
      header: null,
      url: url,
      width: width,
      height: height,
      fit: fit,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
