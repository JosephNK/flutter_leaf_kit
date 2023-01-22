part of lf_photo;

///
/// LFPhotoAlbumSheetTitleView
///
class LFPhotoAlbumSheetTitleView extends StatefulWidget {
  final AssetPathEntity? selectedAssetPath;
  final TextStyle? textStyle;
  final ValueChanged<AssetPathEntity>? onSelected;

  const LFPhotoAlbumSheetTitleView({
    Key? key,
    required this.selectedAssetPath,
    this.textStyle,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumSheetTitleView> createState() =>
      _LFPhotoAlbumSheetTitleViewState();
}

class _LFPhotoAlbumSheetTitleViewState extends State<LFPhotoAlbumSheetTitleView>
    with LFPhotoAlbumRequest {
  List<AssetPathEntity> _assetPathList = [];
  AssetPathEntity? _selectedAssetPath;

  @override
  void initState() {
    super.initState();

    _selectedAssetPath = widget.selectedAssetPath;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final assetPathList = await requestAssetPaths();
      final assetPath = (_selectedAssetPath == null)
          ? assetPathList.first
          : _selectedAssetPath;
      setState(() {
        _assetPathList = assetPathList;
        _selectedAssetPath = assetPath;
      });
      if (assetPath != null && _selectedAssetPath != null) {
        widget.onSelected?.call(assetPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        LFBottomSheet.show<String>(
          context,
          items: _assetPathList
              .map(
                (item) => LFBottomSheetItem<String>(
                  key: item.id,
                  title: item.name,
                ),
              )
              .toList(),
          onTap: (item) {
            final key = item.key;
            final findList = _assetPathList
                .where((assetPath) => assetPath.id == key)
                .toList();
            final assetPath = findList.isNotEmpty ? findList.first : null;
            if (assetPath != null) {
              setState(() {
                _selectedAssetPath = assetPath;
              });
              widget.onSelected?.call(assetPath);
            }
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LFText(
            _selectedAssetPath?.name ?? '',
            style: widget.textStyle ??
                const TextStyle(
                  fontSize: 18.0,
                ),
          ),
          const Icon(Icons.arrow_drop_down_sharp, size: 30.0),
        ],
      ),
    );
  }
}
