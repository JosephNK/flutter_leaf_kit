part of lf_photo;

typedef LFPhotosOnSelected = void Function(List<AssetEntity> selectedEntities);
typedef LFPhotosOnLimitError = void Function(int count);

class LFPhotoView extends StatefulWidget {
  final int selectedLimit;
  final EdgeInsets padding;
  final List<AssetEntity> selectedEntities;
  final Widget? checkedIcon;
  final Widget? uncheckedIcon;
  final Color? selectedBorderColor;
  final LFPhotosOnSelected? onSelected;
  final LFPhotosOnLimitError? onLimitError;

  const LFPhotoView({
    Key? key,
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
  State<LFPhotoView> createState() => _LFPhotoViewState();
}

class _LFPhotoViewState extends State<LFPhotoView> {
  final List<AssetEntity> _selectedEntities = [];

  final int _sizePerPage = 50;

  AssetPathEntity? _path;
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

    _checkedIcon = widget.checkedIcon ?? const Icon(Icons.check_box);
    _uncheckedIcon = widget.uncheckedIcon ?? const Icon(Icons.check_box);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedEntities.addAll(widget.selectedEntities);
      ImageLruCache.clearCache();
      _requestAssets();
    });

    _scrollController.addListener(() {
      final currentPos = _scrollController.offset;
      final maxPos = _scrollController.position.maxScrollExtent;
      if (currentPos >= maxPos && !_isLoadingMore && _hasMoreToLoad) {
        _loadMoreAsset();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
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

              return RepaintBoundary(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _onItemTap(entity, index),
                  child: Stack(
                    children: <Widget>[
                      LFPhotoTile(entity: entity),
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
                ),
              );
            },
          ),
        ),
        // Visibility(
        //   visible: _isLoading,
        //   child: LFCenterIndicator(),
        // ),
      ],
    );
  }

  // Request Assets
  Future<void> _requestAssets() async {
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      setState(() {
        _isLoading = true;
      });

      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );
      if (!mounted) {
        return;
      }
      if (paths.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      setState(() {
        _path = paths.first;
      });
      _totalEntitiesCount = await _path!.assetCountAsync;
      final entities = await _path!.getAssetListPaged(
        page: 0,
        size: _sizePerPage,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _entities = entities;
        _isLoading = false;
        _hasMoreToLoad = _entities.length < _totalEntitiesCount;
      });
    } else {
      await PhotoManager.openSetting();
    }
  }

  // Load More
  Future<void> _loadMoreAsset() async {
    final entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
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
    if (_selectedEntities.length > widget.selectedLimit) {
      if (_selectedEntities.contains(data)) {
        _selectedEntities.remove(data);
      }
      final int limit = widget.selectedLimit;
      widget.onLimitError?.call(limit);
      return;
    }
    setState(() {});
    widget.onSelected?.call(_selectedEntities);
  }
}

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
    return Stack(
      children: [
        Image.memory(
          data,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

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
        //color: showMask ? Colors.black.withOpacity(0.5) : Colors.transparent,
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
