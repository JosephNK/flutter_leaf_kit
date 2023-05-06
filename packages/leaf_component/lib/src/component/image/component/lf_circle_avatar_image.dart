part of lf_image;

class LFCircleAvatarImage extends StatelessWidget {
  final LFImageValue image;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final BoxFit fit;
  final Map<String, String>? header;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFCircleAvatarImage({
    Key? key,
    required this.image,
    this.size = 50,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.fit = BoxFit.cover,
    this.header,
    this.placeholderWidget,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0), // Border width
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipOval(
        child: SizedBox.fromSize(
          size: Size.fromRadius(size), // Image radius
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget? _buildImageWidget() {
    final image = this.image;
    final file = image.file ?? '';
    final bytes = image.bytes;

    if (bytes != null) {
      return LFMemoryImage(
        bytes: bytes,
        width: size,
        height: size,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    if (isURL(file)) {
      return LFCacheImage(
        header: header,
        url: file,
        width: size,
        height: size,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    return LFAssetImage(
      path: file,
      width: size,
      height: size,
      fit: fit,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
