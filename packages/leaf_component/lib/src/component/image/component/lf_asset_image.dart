part of '../lf_image.dart';

class LFAssetFileImage extends StatelessWidget {
  final Uri? uri;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFAssetFileImage({
    super.key,
    required this.uri,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.placeholderWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final uri = this.uri;
    final width = this.width;
    final height = this.height;
    final fit = this.fit;

    final uriString = uri?.toString() ?? '';
    final scheme = uri?.scheme.toLowerCase() ?? '';

    if (!LFImageValue.isNotEmptyUri(uri)) {
      return SizedBox(
        width: width,
        height: height,
        child: _buildPlaceholderImage(context),
      );
    }

    if (scheme.contains('file')) {
      final filePath = uriString.replaceAll('file://', '');
      if (filePath.endsWith('webp')) {
        // https://github.com/flutter/flutter/issues/24858#issuecomment-460544959
        final _ = imageCache.evict(FileImage(File(filePath)));
        // imageCache.clear();
      }
      return Image.file(
        File(filePath),
        fit: fit,
        width: width,
        height: height,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        //   if (wasSynchronouslyLoaded || frame != null) {
        //     return child;
        //   }
        //   return LFSkeleton(color: color);
        // },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage(context);
        },
      );
    }

    return Image(
      image: AssetImage(uriString),
      fit: fit,
      width: width,
      height: height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return LFSkeleton(color: color);
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorImage(context);
      },
    );
  }

  // Placeholder Image
  Widget _buildPlaceholderImage(BuildContext context) {
    return placeholderWidget ?? Container(color: Colors.grey);
  }

  // Error Image
  Widget _buildErrorImage(BuildContext context) {
    return errorWidget ?? const Icon(Icons.error);
  }
}
