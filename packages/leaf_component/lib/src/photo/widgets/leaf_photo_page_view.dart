part of leaf_photo_component;

typedef LeafPhotoPageViewAppBar = PreferredSizeWidget Function(
    int index, int total);
typedef LeafPhotoPageViewPage = Widget Function(
    dynamic data, double width, double height);

class LeafPhotoPageView extends StatefulWidget {
  final LeafPhotoPageViewAppBar appbar;
  final LeafPhotoPageViewPage photo;
  final List<dynamic>? images;
  final List<Size>? sizes;
  final int selectIndex;

  const LeafPhotoPageView({
    Key? key,
    required this.appbar,
    required this.photo,
    this.images,
    this.sizes,
    this.selectIndex = 0,
  }) : super(key: key);

  @override
  State<LeafPhotoPageView> createState() => _LeafPhotoPageViewsState();
}

class _LeafPhotoPageViewsState extends State<LeafPhotoPageView> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.selectIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = widget.appbar;
    final photo = widget.photo;
    final images = widget.images ?? [];
    final index = _currentIndex;

    return Scaffold(
      appBar: appbar.call(index + 1, images.length),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                final image = images.getSafe(index);
                //final size = widget.sizes.getSafe(index);
                return PhotoViewGalleryPageOptions.customChild(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return photo.call(
                        image,
                        constraints.maxWidth,
                        constraints.maxHeight,
                      );
                    },
                  ),
                  initialScale: PhotoViewComputedScale.contained * 0.95,
                  minScale: PhotoViewComputedScale.contained * 0.95,
                  maxScale: 1.0,
                );
              },
              itemCount: images.length,
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 0),
                  ),
                ),
              ),
              pageController: _pageController,
              onPageChanged: onPageChanged,
            ),
          ),
        ],
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
