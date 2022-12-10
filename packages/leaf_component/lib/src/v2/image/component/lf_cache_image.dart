part of lf_image;

///
/// ref., https://iiro.dev/2017/09/04/clipping-widgets-with-bezier-curves-in-flutter/
///
class LFCacheImage extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isClipper;
  final int? cacheWidth;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Map<String, String>? header;
  final Widget? errorWidget;

  const LFCacheImage({
    Key? key,
    this.url,
    this.width = 45,
    this.height = 45,
    this.fit = BoxFit.cover,
    this.isClipper = false,
    this.cacheWidth,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.header,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Logging.d('LeafCacheImage: $url');
    final header = this.header;
    return _buildWrapNetworkImage(
      context,
      url: url,
      httpHeaders: header,
    );
  }

  // Wrap Network Image
  Widget _buildWrapNetworkImage(
    BuildContext context, {
    required String? url,
    required Map<String, String>? httpHeaders,
  }) {
    Widget getClipperWrapperWidget({required Widget child}) {
      return Stack(
        children: [
          ClipPath(
            clipper: LeafImageClipper(useClip: isClipper),
            child: child,
          ),
          CustomPaint(
            painter: LeafBorderPainter(),
            child: SizedBox(
              width: isClipper ? width : 0.0,
              height: isClipper ? height : 0.0,
            ),
          ),
        ],
      );
    }

    if (isEmpty(url)) {
      if (isClipper) {
        return getClipperWrapperWidget(
          child: _buildErrorImage(context),
        );
      }
      return _buildErrorImage(context);
    }

    final networkWidget = _buildNetworkImage(
      context,
      urlString: url!,
      width: width,
      height: height,
      fit: fit,
      httpHeaders: httpHeaders,
    );

    if (isClipper) {
      return getClipperWrapperWidget(
        child: networkWidget,
      );
    }
    return networkWidget;
  }

  // Wrapper Network Image
  Widget _buildNetworkImage(
    BuildContext context, {
    required String urlString,
    required double width,
    required double height,
    required BoxFit fit,
    required Map<String, String>? httpHeaders,
  }) {
    DeviceManager.shared.checkMemory();

    return CachedNetworkImage(
      key: ValueKey(urlString),
      httpHeaders: httpHeaders,
      width: width,
      height: height,
      fit: fit,
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

////////////////////////////////////////////////////////////////////////////////

class LeafImageClipper extends CustomClipper<Path> {
  final bool useClip;

  LeafImageClipper({this.useClip = true});

  @override
  Path getClip(Size size) {
    final d = useClip ? size.width * 0.18 : 0;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - d)
      ..lineTo(size.width - d, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

////////////////////////////////////////////////////////////////////////////////

class LeafBorderPainter extends CustomPainter {
  final bool useClip;

  LeafBorderPainter({this.useClip = true});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    //final d = useClip ? width * 0.18 : 0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black.withOpacity(0.2);
    // final path = Path()
    //   ..moveTo(0, 0)
    //   ..lineTo(size.width, 0)
    //   ..lineTo(size.width, size.height - d)
    //   ..lineTo(size.width - d, size.height)
    //   ..lineTo(0, size.height)
    //   ..lineTo(0, 0);
    // path.close();
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, width, height), Radius.circular(width)))
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

////////////////////////////////////////////////////////////////////////////////

// class LeafCustomImage extends StatelessWidget {
//   final String url;

//   final CachedNetworkImageProvider _imageProvider;
//   final BaseCacheManager cacheManager;

//   LeafCustomImage({
//     Key key,
//     @required this.url,
//     this.cacheManager,
//   })  : assert(url != null),
//         _imageProvider = CachedNetworkImageProvider(
//           url,
//           headers: HTTPManager.cookieHeaders,
//           cacheManager: cacheManager,
//           cacheKey: url,
//         ),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Image>(
//       future: _loadImage(urlString: url),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Container(child: snapshot.data);
//         }
//         return Container();
//       },
//     );
//   }

//   Future<Image> _loadImage({@required String urlString}) {
//     var completer = Completer<Image>();
//     _imageProvider
//         .resolve(ImageConfiguration())
//         .addListener(_onListener(_imageProvider, completer));
//     _imageProvider
//         .resolve(ImageConfiguration())
//         .removeListener(_onListener(_imageProvider, completer));
//     return completer.future;
//   }

//   ImageStreamListener _onListener(
//           ImageProvider provider, Completer completer) =>
//       ImageStreamListener((ImageInfo image, bool synchronousCall) {
//         var _image = image.image;
//         completer.complete(aaaaa(_image));
//         //_image.dispose();
//       }, onError: (dynamic exception, StackTrace stackTrace) {
//         completer.complete(null);
//       });

//   Image aaaaa(ui.Image originalImage) {
//     var _width = originalImage.width.toDouble();
//     var _height = originalImage.height.toDouble();
//     var _size = Size(_width, _height);
//     var _resize = _makeResize(originalImage, width: 120);
//     var _resizeImage = Image(
//       image: ResizeImage.resizeIfNeeded(
//           _resize.width.toInt(), _resize.height.toInt(), _imageProvider),
//     );
//     originalImage.dispose();
//     return _resizeImage;
//   }

//   Size _makeResize(ui.Image src, {int width, int height}) {
//     if (height == null || height <= 0) {
//       height = (width * (src.height / src.width)).toInt();
//     }
//     if (width == null || width <= 0) {
//       width = (height * (src.width / src.height)).toInt();
//     }
//     return Size(width.toDouble(), height.toDouble());
//   }
// }
