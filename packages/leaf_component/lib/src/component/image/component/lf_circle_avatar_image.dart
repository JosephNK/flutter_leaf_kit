part of lf_image;

class LFCircleAvatarImage extends StatelessWidget {
  final Object? image; // String, Uint8List
  final double size;
  final Color borderColor;
  final double borderWidth;
  final Map<String, String>? header;
  final BoxFit fit;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFCircleAvatarImage({
    Key? key,
    required this.image,
    this.size = 50,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.header,
    this.fit = BoxFit.cover,
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

    if (image == null) {
      return SizedBox(
        width: size,
        height: size,
        child: placeholderWidget,
      );
    }

    if (image is String) {
      if (!isURL(image)) {
        return LFAssetImage(
          path: image,
          width: size,
          height: size,
          fit: fit,
          placeholderWidget: placeholderWidget,
          errorWidget: errorWidget,
        );
      }
      return LFCacheImage(
        header: header,
        url: image,
        width: size,
        height: size,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    if (image is Uint8List) {
      return LFMemoryImage(
        bytes: image,
        width: size,
        height: size,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    return Container();
  }
}
