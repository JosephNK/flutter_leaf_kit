import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../../common/theme/leaf_theme.dart';
import 'leaf_asset_image.dart';
import 'leaf_cache_network_image.dart';
import 'leaf_memory_image.dart';

/// A circular avatar image supporting URL, bytes, or asset sources.
///
/// Priority: [bytes] > [url] > [uri] (asset/file).
class LeafCircleAvatarImage extends StatelessWidget {
  final String? url;
  final Uint8List? bytes;
  final Uri? uri;
  final double radius;
  final Color? borderColor;
  final double borderWidth;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final FilterQuality filterQuality;
  final Map<String, String>? headers;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final BaseCacheManager? cacheManager;

  const LeafCircleAvatarImage({
    super.key,
    this.url,
    this.bytes,
    this.uri,
    this.radius = 20.0,
    this.borderColor,
    this.borderWidth = 0.0,
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
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final diameter = radius * 2;
    final resolvedBorderColor = borderColor ?? colors.divider;

    Widget image;
    if (bytes != null && bytes!.isNotEmpty) {
      image = LeafMemoryImage(
        bytes: bytes,
        width: diameter,
        height: diameter,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    } else if (url != null && url!.isNotEmpty) {
      image = LeafCacheNetworkImage(
        url: url,
        width: diameter,
        height: diameter,
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
      image = LeafAssetImage(
        uri: uri,
        width: diameter,
        height: diameter,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        filterQuality: filterQuality,
        placeholderWidget: placeholderWidget,
        errorWidget: errorWidget,
      );
    }

    return Semantics(
      label: 'Avatar image',
      child: Container(
        width: diameter,
        height: diameter,
        decoration: borderWidth > 0
            ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: resolvedBorderColor,
                  width: borderWidth,
                ),
              )
            : null,
        child: ClipOval(child: image),
      ),
    );
  }
}
