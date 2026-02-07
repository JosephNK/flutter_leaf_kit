part of '../image.dart';

@Deprecated('Use LeafAssetImage instead')
class LFAssetFileImage extends StatelessWidget {
  final Uri? uri;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFAssetFileImage({
    super.key,
    required this.uri,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
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
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 3),
            curve: Curves.fastLinearToSlowEaseIn,
            child: child,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage(context);
        },
      );
    }

    return Image.asset(
      uriString,
      fit: fit,
      width: width,
      height: height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 3),
          curve: Curves.fastLinearToSlowEaseIn,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorImage(context);
      },
    );
  }

  // Placeholder Image
  Widget _buildPlaceholderImage(BuildContext context) {
    final baseColor = shimmerBaseColor;
    final highlightColor = (shimmerHighlightColor != null)
        ? shimmerHighlightColor
        : baseColor?.withValues(alpha: 0.5);
    return placeholderWidget ??
        LFSkeleton(baseColor: baseColor, highlightColor: highlightColor);
  }

  // Error Image
  Widget _buildErrorImage(BuildContext context) {
    final baseColor = shimmerBaseColor;
    return errorWidget ??
        Container(
          color: baseColor ?? Colors.grey[300],
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.error),
          ),
        );
  }
}
