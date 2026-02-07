import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../theme/lf_theme.dart';
import 'lf_asset_image_v2.dart';
import 'lf_cache_network_image_v2.dart';

/// A high-level image widget that routes to [LFCacheNetworkImageV2] for URLs
/// or [LFAssetImageV2] for asset/file URIs.
///
/// Optionally wraps with [ClipRRect] for rounded corners.
class LFCacheImageV2 extends StatelessWidget {
  final Uri? uri;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final double? borderRadius;
  final Map<String, String>? headers;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const LFCacheImageV2({
    super.key,
    this.uri,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.borderRadius,
    this.headers,
    this.placeholderWidget,
    this.errorWidget,
    this.cacheManager,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
    final imageTheme = theme.imageTheme;
    final resolvedRadius = borderRadius ?? imageTheme?.borderRadius ?? 0.0;

    Widget image;
    if (_isNetworkUrl(uri)) {
      image = LFCacheNetworkImageV2(
        url: uri.toString(),
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        headers: headers,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
        cacheManager: cacheManager,
      );
    } else {
      image = LFAssetImageV2(
        uri: uri,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    if (resolvedRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(resolvedRadius),
        child: image,
      );
    }

    return image;
  }

  static bool _isNetworkUrl(Uri? uri) {
    if (uri == null) return false;
    final scheme = uri.scheme.toLowerCase();
    return scheme == 'http' || scheme == 'https';
  }
}
