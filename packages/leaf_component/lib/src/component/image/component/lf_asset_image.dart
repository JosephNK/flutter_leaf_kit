part of '../lf_image.dart';

class LFAssetFileImage extends StatelessWidget {
  final String path;
  final Color? color;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFAssetFileImage({
    super.key,
    required this.path,
    this.color,
    this.width = 45.0,
    this.height = 45.0,
    this.fit = BoxFit.cover,
    this.placeholderWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final path = this.path;
    final width = this.width;
    final height = this.height;
    final fit = this.fit;

    if (isEmpty(path)) {
      return SizedBox(
        width: width,
        height: height,
        child: _buildPlaceholderImage(context),
      );
    }

    if (path.startsWith('file://')) {
      final filePath = path.replaceAll('file://', '');
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
      image: AssetImage(path),
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
