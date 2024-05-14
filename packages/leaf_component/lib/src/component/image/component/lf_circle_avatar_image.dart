part of '../image.dart';

class LFCircleAvatarImage extends StatelessWidget {
  final LFImageValue image;
  final double size;
  final Color borderColor;
  final double borderWidth;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Map<String, String>? header;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const LFCircleAvatarImage({
    super.key,
    required this.image,
    this.size = 50,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.header,
    this.placeholderWidget,
    this.errorWidget,
    this.cacheManager,
  });

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

    if (image.isThumbnailOrOriginURL) {
      return LFCacheImage(
        header: header,
        uri: image.getThumbnailOrOriginURL,
        width: size,
        height: size,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
        cacheManager: cacheManager,
      );
    }

    return LFAssetFileImage(
      uri: image.getThumbnailOrOrigin,
      width: size,
      height: size,
      fit: fit,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
