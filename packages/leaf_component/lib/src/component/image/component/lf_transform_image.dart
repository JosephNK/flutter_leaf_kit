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
    final file = image.file ?? '';
    final thumbFile = image.thumbFile ?? '';
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
    String? urlFile;
    if (isURL(thumbFile)) {
      urlFile = thumbFile;
    } else if (isURL(file)) {
      urlFile = file;
    }
    if (urlFile != null) {
      return LFCacheImage(
        header: header,
        url: urlFile,
        width: width,
        height: height,
        fit: fit,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    /// Asset
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
