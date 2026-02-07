import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../../common/theme/leaf_theme.dart';
import '../../skeleton/widget/leaf_skeleton.dart';

/// A network image widget with caching support.
///
/// Wraps [CachedNetworkImage] with placeholder / error / theme integration.
class LeafCacheNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Map<String, String>? headers;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const LeafCacheNetworkImage({
    super.key,
    this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
    this.filterQuality = FilterQuality.low,
    this.headers,
    this.placeholderWidget,
    this.errorWidget,
    this.cacheManager,
  });

  @override
  Widget build(BuildContext context) {
    final urlString = url ?? '';
    if (urlString.isEmpty) {
      return _buildError(context);
    }

    return CachedNetworkImage(
      key: ValueKey(urlString),
      imageUrl: urlString,
      width: width,
      height: height,
      fit: fit,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      filterQuality: filterQuality,
      httpHeaders: headers,
      cacheManager: cacheManager,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      placeholder: (_, _) =>
          placeholderWidget ??
          LeafSkeleton(width: width ?? 100, height: height ?? 100),
      errorWidget: (_, _, _) => _buildError(context),
    );
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
