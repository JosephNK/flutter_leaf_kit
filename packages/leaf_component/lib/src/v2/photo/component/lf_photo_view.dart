part of lf_photo;

typedef LFPhotosOnSelected = void Function(
  List<AssetEntity> selectedEntities,
);
typedef LFPhotosOnLimitError = void Function(
  Exception error,
  int limit,
);

///
/// LFPhotoAlbumView
///
class LFPhotoAlbumView extends StatefulWidget {
  final AssetPathEntity? selectedAssetPath;
  final TextStyle? textStyle;
  final ValueChanged<AssetPathEntity>? onSelected;

  const LFPhotoAlbumView({
    Key? key,
    required this.selectedAssetPath,
    this.textStyle,
    this.onSelected,
  }) : super(key: key);

  @override
  State<LFPhotoAlbumView> createState() => _LFPhotoAlbumViewState();
}

class _LFPhotoAlbumViewState extends State<LFPhotoAlbumView> {
  List<AssetPathEntity> _assetPathList = [];
  AssetPathEntity? _selectedAssetPath;

  @override
  void initState() {
    super.initState();

    _selectedAssetPath = widget.selectedAssetPath;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final assetPathList = await _requestAssetPaths();
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

  Future<List<AssetPathEntity>> _requestAssetPaths() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.common,
        filterOption: FilterOptionGroup(
          containsPathModified: true,
          containsLivePhotos: false,
        ),
      );
      return paths;
    } else {
      await PhotoManager.openSetting();
    }
    return [];
  }
}

///
/// LFPhotoContentView
///
class LFPhotoContentView extends StatefulWidget {
  final AssetPathEntity? selectedAssetPath;
  final int selectedLimit;
  final EdgeInsets padding;
  final List<AssetEntity> selectedEntities;
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final Color? selectedBorderColor;
  final LFPhotosOnSelected? onSelected;
  final LFPhotosOnLimitError? onLimitError;

  const LFPhotoContentView({
    Key? key,
    required this.selectedAssetPath,
    this.selectedLimit = 3,
    this.padding = const EdgeInsets.all(0),
    this.selectedEntities = const [],
    this.checkedIcon,
    this.uncheckedIcon,
    this.selectedBorderColor,
    this.onSelected,
    this.onLimitError,
  }) : super(key: key);

  @override
  State<LFPhotoContentView> createState() => _LFPhotoContentViewState();
}

class _LFPhotoContentViewState extends State<LFPhotoContentView> {
  AssetPathEntity? _selectedAssetPath;
  final List<AssetEntity> _selectedEntities = [];
  final int _sizePerPage = 50;

  List<AssetEntity> _entities = [];
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  final ScrollController _scrollController = ScrollController();

  Widget? _checkedIcon;
  Widget? _uncheckedIcon;

  @override
  void initState() {
    super.initState();

    _checkedIcon = widget.checkedIcon ??
        const Icon(
          Icons.check_box,
          color: Colors.blueAccent,
        );
    _uncheckedIcon = widget.uncheckedIcon ??
        Icon(
          Icons.check_box_outline_blank,
          color: Colors.grey.withOpacity(0.8),
        );

    _scrollController.addListener(() {
      final currentPos = _scrollController.offset;
      final maxPos = _scrollController.position.maxScrollExtent;
      if (currentPos >= maxPos && !_isLoadingMore && _hasMoreToLoad) {
        _loadMoreAsset();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ImageLruCache.clearCache();
      _selectedEntities.addAll(widget.selectedEntities);
      _selectedAssetPath = widget.selectedAssetPath;
      _requestAssets();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LFPhotoContentView oldWidget) {
    if (oldWidget.selectedAssetPath != widget.selectedAssetPath) {
      _selectedAssetPath = widget.selectedAssetPath;
      _requestAssets();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: widget.padding,
          child: GridView.builder(
            itemCount: _entities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              final entity = _entities[index];
              final checked = _selectedEntities.contains(entity);

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _onItemTap(entity, index),
                child: Stack(
                  children: <Widget>[
                    LFPhotoTile(
                      entity: entity,
                    ),
                    LFPhotoMask(
                      showMask: checked,
                      borderColor: widget.selectedBorderColor,
                    ),
                    Positioned(
                      top: 0,
                      right: 4,
                      child: LFPhotoCheckBox(
                        checkedIcon: _checkedIcon,
                        uncheckedIcon: _uncheckedIcon,
                        checked: checked,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Request Assets
  Future<void> _requestAssets() async {
    if (!mounted) return;
    if (_isLoading) return;
    if (_selectedAssetPath == null) return;

    setState(() {
      _isLoading = true;
    });

    _totalEntitiesCount = await _selectedAssetPath!.assetCountAsync;
    final entities = await _selectedAssetPath!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );

    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities.length < _totalEntitiesCount;
    });
  }

  // Load More
  Future<void> _loadMoreAsset() async {
    if (!mounted) return;
    if (_isLoadingMore) return;
    if (_selectedAssetPath == null) return;

    setState(() {
      _isLoadingMore = true;
    });

    final entities = await _selectedAssetPath!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );

    setState(() {
      _entities.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  // Event
  void _onItemTap(AssetEntity data, int index) {
    final isExist = _selectedEntities.contains(data);
    !isExist ? _selectedEntities.add(data) : _selectedEntities.remove(data);
    if (!isExist && widget.selectedLimit == 1) {
      _selectedEntities.clear();
      _selectedEntities.add(data);
    }
    if (_selectedEntities.length > widget.selectedLimit) {
      if (_selectedEntities.contains(data)) {
        _selectedEntities.remove(data);
      }
      final int limit = widget.selectedLimit;
      widget.onLimitError
          ?.call(Exception('Selection $limit limit is restricted.'), limit);
      return;
    }
    setState(() {});
    widget.onSelected?.call(_selectedEntities);
  }
}

///
/// LFPhotoTile
///
class LFPhotoTile extends StatelessWidget {
  final AssetEntity entity;
  final int size;

  const LFPhotoTile({
    Key? key,
    required this.entity,
    this.size = 64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thumb = ImageLruCache.getData(entity);
    if (thumb != null) {
      return _buildImageItem(context, thumb);
    }
    return FutureBuilder<Uint8List?>(
      future: entity.thumbnailData,
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        final futureData = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done &&
            futureData != null) {
          ImageLruCache.setData(entity, size, futureData);
          return _buildImageItem(context, futureData);
        }
        return Container();
      },
    );
  }

  Widget _buildImageItem(BuildContext context, Uint8List data) {
    Duration videoDuration = entity.videoDuration;

    return Stack(
      children: [
        Image.memory(
          data,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: Visibility(
            visible: entity.type == AssetType.video,
            child: LFText(
              videoDuration.toString().split('.').first.padLeft(8, '0'),
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

///
/// LFPhotoMask
///
class LFPhotoMask extends StatelessWidget {
  final bool showMask;
  final Color? borderColor;

  const LFPhotoMask({
    Key? key,
    required this.showMask,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: showMask
            ? BoxDecoration(
                border: Border.all(
                    color: borderColor ?? Colors.blueAccent, width: 3),
              )
            : BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0),
              ),
      ),
    );
  }
}

///
/// LFPhotoCheckBox
///
class LFPhotoCheckBox extends StatelessWidget {
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final bool checked;

  const LFPhotoCheckBox({
    Key? key,
    this.checkedIcon,
    this.uncheckedIcon,
    this.checked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: checked ? checkedIcon : uncheckedIcon,
    );
  }
}
