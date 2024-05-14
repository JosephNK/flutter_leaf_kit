part of '../image.dart';

class LFCachedNetworkImageProvider
    extends cached_network.CachedNetworkImageProvider {
  /// Creates an ImageProvider which loads an image from the [url], using the [scale].
  /// When the image fails to load [errorListener] is called.
  const LFCachedNetworkImageProvider(
    super.url, {
    super.maxHeight,
    super.maxWidth,
    super.scale,
    super.errorListener,
    super.headers,
    super.cacheManager,
    super.cacheKey,
  });
}
