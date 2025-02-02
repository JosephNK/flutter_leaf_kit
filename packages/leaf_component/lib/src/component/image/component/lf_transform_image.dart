part of '../image.dart';

class LFTransformImage extends StatelessWidget {
  final LFImageValue image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final double? borderRadius;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
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
    this.borderRadius,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
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
      return _buildWrapper(
        child: LFMemoryImage(
          bytes: bytes,
          width: width,
          height: height,
          fit: fit,
          shimmerBaseColor: shimmerBaseColor,
          shimmerHighlightColor: shimmerHighlightColor,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          filterQuality: filterQuality,
          placeholderWidget: placeholderWidget,
          errorWidget: errorWidget,
        ),
      );
    }

    /// Network URL
    if (image.isThumbnailOrOriginURL) {
      return _buildWrapper(
        child: LFCacheImage(
          header: header,
          uri: image.getThumbnailOrOriginURL,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: cacheWidth,
          cacheHeight: cacheHeight,
          filterQuality: filterQuality,
          shimmerBaseColor: shimmerBaseColor,
          shimmerHighlightColor: shimmerHighlightColor,
          placeholderWidget: placeholderWidget,
          errorWidget: errorWidget,
          cacheManager: cacheManager,
        ),
      );
    }

    /// Asset
    return _buildWrapper(
      child: LFAssetFileImage(
        uri: image.getThumbnailOrOrigin,
        width: width,
        height: height,
        fit: fit,
        shimmerBaseColor: shimmerBaseColor,
        shimmerHighlightColor: shimmerHighlightColor,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      ),
    );
  }

  Widget _buildWrapper({
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        child: child,
      ),
    );
  }
}
