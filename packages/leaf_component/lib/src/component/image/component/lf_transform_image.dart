part of '../lf_image.dart';

class LFTransformImage extends StatelessWidget {
  final LFImageValue image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const LFTransformImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.placeholderWidget,
    this.errorWidget,
    this.cacheManager,
  });

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    final bytes = image.bytes;
    final header = image.header;

    /// Memory Byte
    if (bytes != null) {
      return LFMemoryImage(
        bytes: bytes,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    /// Network URL
    if (image.isThumbnailOrOriginURL) {
      return LFCacheImage(
        header: header,
        uri: image.getThumbnailOrOriginURL,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
        cacheManager: cacheManager,
      );
    }

    /// Asset
    return LFAssetFileImage(
      uri: image.getThumbnailOrOrigin,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      filterQuality: filterQuality,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
