part of '../lf_image.dart';

typedef LFCacheNetworkImageOnPreBuilder = Function();

class LFCacheNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Map<String, String>? header;
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final LFCacheNetworkImageOnPreBuilder? onPreBuilder;

  const LFCacheNetworkImage({
    super.key,
    this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.header,
    this.placeholderWidget,
    this.errorWidget,
    this.onPreBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return _buildNetworkImage(
      context,
      urlString: url!,
      width: width,
      height: height,
      fit: fit,
      httpHeaders: header,
    );
  }

  // Wrapper Network Image
  Widget _buildNetworkImage(
    BuildContext context, {
    required String urlString,
    required double? width,
    required double? height,
    required BoxFit fit,
    required Map<String, String>? httpHeaders,
  }) {
    onPreBuilder?.call(); // LFDeviceManager.shared.checkMemory();

    return cached_network.CachedNetworkImage(
      key: ValueKey(urlString),
      httpHeaders: httpHeaders,
      width: width,
      height: height,
      fit: fit,
      cacheManager: CustomCacheManager.instance,
      placeholderFadeInDuration: const Duration(milliseconds: 0),
      fadeOutDuration: const Duration(milliseconds: 0),
      fadeInDuration: const Duration(milliseconds: 0),
      imageUrl: urlString,
      memCacheWidth: cacheWidth,
      //memCacheHeight: 500,
      //filterQuality: FilterQuality.high,
      placeholder: (context, url) {
        return _buildPlaceholderLoaderImage(context);
      },
      errorWidget: (context, url, error) {
        return _buildErrorImage(context);
      },
    );
  }

  // Placeholder Loader Image
  Widget _buildPlaceholderLoaderImage(BuildContext context) {
    return LFSkeleton(width: width, height: height);
  }

  // Error Image
  Widget _buildErrorImage(BuildContext context) {
    return errorWidget ?? const Icon(Icons.error);
  }
}

class CustomCacheManager {
  static const key = 'LFCachedImageData';
  static CacheManager instance = CacheManager(
    Config(
      key,
      // stalePeriod: const Duration(days: 7),
      // maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: key),
      // fileSystem: IOFileSystem(key),
      // fileService: HttpFileService(),
    ),
  );
}
