part of lf_image;

class LFCombineImage extends StatelessWidget {
  final LFImageValue image;
  final double width;
  final double height;
  final BoxFit fit;
  final Map<String, String>? header;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFCombineImage({
    Key? key,
    required this.image,
    this.width = 45.0,
    this.height = 45.0,
    this.fit = BoxFit.cover,
    this.header,
    this.placeholderWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    final file = image.file ?? '';
    final bytes = image.bytes;

    if (bytes != null) {
      return LFMemoryImage(
        bytes: bytes,
        width: width,
        height: height,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    if (isURL(file)) {
      return LFCacheImage(
        header: header,
        url: file,
        width: width,
        height: height,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    return LFAssetFileImage(
      path: file,
      width: width,
      height: height,
      fit: fit,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
