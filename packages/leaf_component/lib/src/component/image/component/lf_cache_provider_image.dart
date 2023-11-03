part of lf_image;

class LFCachedNetworkImageProvider
    extends cached_network.CachedNetworkImageProvider {
  /// Creates an ImageProvider which loads an image from the [url], using the [scale].
  /// When the image fails to load [errorListener] is called.
  const LFCachedNetworkImageProvider(
    String url, {
    int? maxHeight,
    int? maxWidth,
    double scale = 1.0,
    cached_network_interface.ErrorListener? errorListener,
    Map<String, String>? headers,
    BaseCacheManager? cacheManager,
    String? cacheKey,
  }) : super(
          url,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          scale: scale,
          errorListener: errorListener,
          headers: headers,
          cacheManager: cacheManager,
          cacheKey: cacheKey,
        );
}
