part of '../lf_image.dart';

class LFMemoryImage extends StatelessWidget {
  final Uint8List? bytes;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFMemoryImage({
    super.key,
    required this.bytes,
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
    final bytes = this.bytes;

    if (bytes == null) {
      return SizedBox(
        width: width,
        height: height,
        child: _buildPlaceholderImage(context),
      );
    }

    return Image.memory(
      bytes,
      fit: fit,
      width: width,
      height: height,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      filterQuality: filterQuality,
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
