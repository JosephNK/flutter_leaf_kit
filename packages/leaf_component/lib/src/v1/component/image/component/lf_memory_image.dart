part of '../image.dart';

@Deprecated('Use LFMemoryImageV2 instead')
class LFMemoryImage extends StatelessWidget {
  final Uint8List? bytes;
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

  const LFMemoryImage({
    super.key,
    required this.bytes,
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
    final bytes = this.bytes;

    if (bytes == null) {
      return SizedBox(
        width: width,
        height: height,
        child: _buildPlaceholderImage(context),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          _buildPlaceholderImage(context),
          Image.memory(
            bytes,
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
          ),
        ],
      ),
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
