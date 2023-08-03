part of lf_photo;

///
/// LFPhotoAlbumScrollTitleView
///
class LFPhotoAlbumScrollTitleView extends StatefulWidget {
  final RequestType type;
  final AssetPathEntity? selectedAssetPath;
  final TextStyle? textStyle;
  final bool visibleAlbumView;
  final String? recentName;
  final VoidCallback? onPressed;
  final ValueChanged<AssetPathEntity>? onFirstLoadSelected;

  const LFPhotoAlbumScrollTitleView({
    Key? key,
    required this.type,
    required this.selectedAssetPath,
    this.textStyle,
    this.visibleAlbumView = false,
    this.recentName,
    this.onPressed,
    this.onFirstLoadSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumScrollTitleView> createState() =>
      _LFPhotoAlbumScrollTitleViewState();
}

class _LFPhotoAlbumScrollTitleViewState
    extends State<LFPhotoAlbumScrollTitleView> with LFPhotoAlbumRequest {
  AssetPathEntity? _selectedAssetPath;

  @override
  void initState() {
    super.initState();

    _selectedAssetPath = widget.selectedAssetPath;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final assetPathList = await requestAssetPaths(widget.type);
      final assetPath = (_selectedAssetPath == null)
          ? assetPathList.first
          : _selectedAssetPath;
      setState(() {
        _selectedAssetPath = assetPath;
      });
      if (assetPath != null && _selectedAssetPath != null) {
        widget.onFirstLoadSelected?.call(assetPath);
      }
    });
  }

  @override
  void didUpdateWidget(covariant LFPhotoAlbumScrollTitleView oldWidget) {
    if (oldWidget.selectedAssetPath != widget.selectedAssetPath) {
      setState(() {
        _selectedAssetPath = widget.selectedAssetPath;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final recentName = widget.recentName;
    String albumName = _selectedAssetPath?.name ?? '';
    if (albumName == 'Recent' && recentName != null) {
      albumName = recentName;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onPressed?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LFText(
            albumName,
            style: widget.textStyle ??
                const TextStyle(
                  fontSize: 18.0,
                ),
          ),
          widget.visibleAlbumView
              ? const Icon(Icons.arrow_drop_up_sharp, size: 30.0)
              : const Icon(Icons.arrow_drop_down_sharp, size: 30.0),
        ],
      ),
    );
  }
}
