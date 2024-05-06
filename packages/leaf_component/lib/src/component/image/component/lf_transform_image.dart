part of '../lf_image.dart';

class LFTransformImage extends StatelessWidget {
  final LFImageValue image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFTransformImage({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderWidget,
    this.errorWidget,
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
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    /// Asset
    return LFAssetFileImage(
      uri: image.getThumbnailOrOrigin,
      width: width,
      height: height,
      fit: fit,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );
  }
}
