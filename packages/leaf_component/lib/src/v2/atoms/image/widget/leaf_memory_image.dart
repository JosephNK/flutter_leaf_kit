import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';
import '../../skeleton/widget/leaf_skeleton.dart';

/// An image widget that renders from in-memory byte data.
class LeafMemoryImage extends StatelessWidget {
  final Uint8List? bytes;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LeafMemoryImage({
    super.key,
    this.bytes,
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
    if (bytes == null || bytes.isEmpty) {
      return _buildError(context);
    }

    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      filterQuality: filterQuality,
      frameBuilder: _frameBuilder,
      errorBuilder: (_, _, _) => _buildError(context),
    );
  }

  Widget _frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded || frame != null) return child;
    return placeholderWidget ??
        LeafSkeleton(width: width ?? 100, height: height ?? 100);
  }

  Widget _buildError(BuildContext context) {
    if (errorWidget != null) return errorWidget!;
    final theme = LeafTheme.of(context);
    final imageTheme = theme.imageTheme;
    final errorColor = imageTheme?.errorColor ?? theme.colors.error;

    return SizedBox(
      width: width,
      height: height,
      child: Center(child: Icon(Icons.broken_image, color: errorColor)),
    );
  }
}
