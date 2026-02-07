import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../common/theme/lf_theme.dart';
import '../../skeleton/widget/lf_skeleton_v2.dart';

/// An image widget that loads from asset paths or file URIs.
///
/// Detects `file://` scheme to use [Image.file], otherwise [Image.asset].
class LFAssetImageV2 extends StatelessWidget {
  final Uri? uri;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFAssetImageV2({
    super.key,
    this.uri,
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
    if (uri == null || uri.toString().isEmpty) {
      return _buildError(context);
    }

    final isFileUri = uri.scheme == 'file';
    if (isFileUri) {
      return Image.file(
        File(uri.toFilePath()),
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

    return Image.asset(
      uri.toString(),
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
        LFSkeletonV2(width: width ?? 100, height: height ?? 100);
  }

  Widget _buildError(BuildContext context) {
    if (errorWidget != null) return errorWidget!;
    final theme = LFTheme.of(context);
    final imageTheme = theme.imageTheme;
    final errorColor = imageTheme?.errorColor ?? theme.colors.error;

    return SizedBox(
      width: width,
      height: height,
      child: Center(child: Icon(Icons.broken_image, color: errorColor)),
    );
  }
}
