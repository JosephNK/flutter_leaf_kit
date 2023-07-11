part of lf_image;

///
/// ref., https://iiro.dev/2017/09/04/clipping-widgets-with-bezier-curves-in-flutter/
///
class LFCacheImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isClipper;
  final int? cacheWidth;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Map<String, String>? header;
  final Widget? placeholderWidget;
  final Widget? errorWidget;

  const LFCacheImage({
    Key? key,
    this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isClipper = false,
    this.cacheWidth,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.header,
    this.placeholderWidget,
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
    final url = this.url ?? '';

    Widget getClipperWrapperWidget({required Widget child}) {
      return Stack(
        children: [
          ClipPath(
            clipper: LFImageClipper(useClip: isClipper),
            child: child,
          ),
          CustomPaint(
            painter: LFBorderPainter(),
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
          child: _buildPlaceholderImage(context),
        );
      }
      return _buildPlaceholderImage(context);
    }

    if (url.endsWith('webp')) {
      return LFWebpCacheNetworkImage(
        url: url,
        width: width,
        height: height,
        header: header,
      );
    }

    final networkWidget = LFCacheNetworkImage(
      url: url,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      shimmerBaseColor: shimmerBaseColor,
      shimmerHighlightColor: shimmerHighlightColor,
      header: httpHeaders,
      placeholderWidget: placeholderWidget,
      errorWidget: errorWidget,
    );

    if (isClipper) {
      return getClipperWrapperWidget(
        child: networkWidget,
      );
    }
    return networkWidget;
  }

  // Placeholder Image
  Widget _buildPlaceholderImage(BuildContext context) {
    return placeholderWidget ?? Container(color: Colors.grey);
  }
}

////////////////////////////////////////////////////////////////////////////////

class LFWebpCacheNetworkImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final Map<String, String>? header;

  const LFWebpCacheNetworkImage({
    super.key,
    required this.url,
    required this.width,
    required this.height,
    required this.header,
  });

  @override
  State<LFWebpCacheNetworkImage> createState() =>
      _LFWebpCacheNetworkImageState();
}

class _LFWebpCacheNetworkImageState extends State<LFWebpCacheNetworkImage> {
  bool _play = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _ = await LFCachedNetworkImageProvider(widget.url).evict();
      setState(() => _play = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        image: (!_play)
            ? null
            : DecorationImage(
                image: LFCachedNetworkImageProvider(
                  widget.url,
                  headers: widget.header,
                ),
              ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class LFImageClipper extends CustomClipper<Path> {
  final bool useClip;

  LFImageClipper({this.useClip = true});

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

class LFBorderPainter extends CustomPainter {
  final bool useClip;

  LFBorderPainter({this.useClip = true});

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
